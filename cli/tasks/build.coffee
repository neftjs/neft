'use strict'

fs = require 'fs-extra'
cliUtils = require '../utils'
chokidar = require 'chokidar'
notifier = require 'node-notifier'
pathUtils = require 'path'

{utils, log} = Neft

parseApp = require './build/parse'
createBundle = require './build/bundle'
saveBundle = require './build/saveBundle'

NOTIFY_ICON_PATH = pathUtils.join __dirname, '../../media/logo-white.png'

clear = (platform, callback) ->
    fs.remove './index.js', callback

watch = (platform, options, callback) ->
    changedFiles = []
    isWaiting = false
    isPending = false
    shouldBuildAgain = false

    ignored = '^(?:build|index\.js|local\.json|node_modules)|\.git'
    if options.out
        ignored += "|#{options.out}"

    update = ->
        isWaiting = false
        if isPending
            shouldBuildAgain = true
            return

        isPending = true
        buildOptions = utils.mergeAll {}, options,
            changedFiles: changedFiles
        changedFiles = []
        build platform, buildOptions, (err) ->
            isPending = false
            console.log ''
            callback err

            if shouldBuildAgain
                shouldBuildAgain = false
                update()

    chokidar.watch('.', ignored: new RegExp(ignored)).on 'all', (event, path) ->
        if event is 'change'
            changedFiles.push fs.realpathSync path
        unless isWaiting
            setTimeout update, 200
            isWaiting = true
        return
    return

build = (platform, options, callback) ->
    # create build folder
    fs.ensureDirSync './build'

    stack = new utils.async.Stack
    args = [platform, options, null]

    # create temporary 'index.js' file
    stack.add ((platform, options, callback) ->
        parseApp platform, options, (err, app) ->
            args[2] = app
            callback err
    ), null, args

    # create bundle files
    stack.add createBundle, null, args

    # save output if needed
    if options.out
        stack.add saveBundle, null, args

    # clear
    stack.add clear, null, args

    # notify
    if options.notify
        callback = do (callback) -> (err) ->
            notifier.notify
                title: 'Neft'
                icon: NOTIFY_ICON_PATH
                subtitle: if err then "Error" else ''
                message: if err then err.name or err else 'Build ready'
            callback err

    # run
    stack.runAll callback

module.exports = (platform, options, callback) ->
    unless cliUtils.verifyNeftProject('./')
        return

    # watch for changes
    if options.watch
        watch platform, options, callback
        return

    build platform, options, callback
