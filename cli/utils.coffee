'use strict'

pathUtils = require 'path'
fs = require 'fs'
childProcess = require 'child_process'
utils = require 'src/utils'
log = require 'src/log'
assert = require 'src/assert'

exports.verifyNeftProject = (path) ->
    src = pathUtils.resolve path, './package.json'
    unless fs.existsSync(src)
        log.error 'No Neft project found'
        false
    else
        true

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
        local:
            local: true
        npm:
            npm: true
        node:
            node: true
            server: true
        browser:
            browser: true
            client: true
        webgl:
            webgl: true
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

LOCAL_IP = do ->
    cmd = """
        ifconfig | \
        grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | \
        grep -Eo '([0-9]*\\.){3}[0-9]*' | \
        grep -v '127.0.0.1'
    """
    out = try childProcess.execSync cmd, stdio: 'pipe'
    out ?= try childProcess.execSync 'ipconfig getifaddr en0', stdio: 'pipe'
    if out
        String(out).split('\n')[0].trim()
    else
        log.warn "Cannot resolve local IP address; is ifconfig or ipconfig commands available?"
        ''

exports.isLocalHost = (host) ->
    String(host).toLowerCase() is 'localhost'

exports.getValidHost = (host) ->
    if exports.isLocalHost(host) and LOCAL_IP
        LOCAL_IP
    else
        host
