'use strict'

pathUtils = require 'path'
fs = require 'fs'

{utils, log, assert} = Neft

exports.verifyNeftProject = (path) ->
    result = false

    src = pathUtils.resolve path, './package.json'
    if fs.existsSync(src)
        json = JSON.parse fs.readFileSync src, 'utf-8'
        if json.config?.type
            result = true

    unless result
        log.error "No Neft project found"

    result

exports.forEachFileDeep = (dir, onFile, onEnd) ->
    assert.isString dir
    assert.isFunction onFile
    assert.isFunction onEnd

    ready = length = 0
    onReady = ->
        if ++ready is length
            onEnd null

    proceedFile = (path) ->
        fs.stat path, (err, stat) ->
            if err
                return onEnd err

            if stat.isFile()
                onFile path, stat
                onReady()
            else
                exports.forEachFileDeep path, onFile, onReady

    fs.readdir dir, (err, files) ->
        if err or files.length is 0
            return onEnd err

        for file in files
            if file[0] isnt '.'
                length++
                filePath = "#{dir}/#{file}"
                proceedFile filePath

        return
    return

exports.isPlatformFilePath = do ->
    PLATFORM_TYPES =
        node:
            node: true
            server: true
        browser:
            browser: true
            client: true
        qt:
            qt: true
            client: true
            native: true
        android:
            android: true
            client: true
            native: true
        ios:
            ios: true
            client: true
            native: true

    SPECIAL_EXTS = do ->
        r = {}
        for _, exts of PLATFORM_TYPES
            utils.merge r, exts
        r

    (platform, filePath) ->
        if linkTypeMatch = /^(.+?)\.([a-zA-Z]+)\.([a-zA-Z]+)$/.exec(filePath)
            linkType = linkTypeMatch[2]

            if linkType and SPECIAL_EXTS[linkType]
                return PLATFORM_TYPES[platform][linkType]

        return true
