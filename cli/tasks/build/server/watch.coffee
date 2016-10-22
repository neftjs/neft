'use strict'

chokidar = require 'chokidar'
fs = require 'fs'
utils = require 'src/utils'

module.exports = (platform, options, onBuild) ->
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
            buildBundleOnly: true
        changedFiles = []
        onBuild buildOptions, ->
            isPending = false

            if shouldBuildAgain
                shouldBuildAgain = false
                update()

    chokidarOptions =
        ignored: new RegExp ignored
        ignoreInitial: true
    chokidar.watch('.', chokidarOptions).on 'all', (event, path) ->
        if event is 'change'
            changedFiles.push fs.realpathSync path
        unless isWaiting
            setTimeout update, 200
            isWaiting = true
        return
