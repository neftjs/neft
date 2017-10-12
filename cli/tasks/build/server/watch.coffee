'use strict'

chokidar = require 'chokidar'
fs = require 'fs'
glob = require 'glob'
Module = require 'module'
utils = require 'src/utils'
moduleCache = require 'lib/module-cache'

module.exports = (platform, options, onBuild) ->
    changedFiles = []
    isWaiting = false
    isPending = false
    shouldBuildAgain = false
    files = Object.create null

    ignored = '^(?:build|index\\.js|local\\.json|node_modules)'
    ignored += '|(^|[\\/\\\\])\\..' # hidden paths
    if options.out
        ignored += "|^#{options.out}"

    update = ->
        isWaiting = false
        if isPending
            shouldBuildAgain = true
            return

        # add build files into changed files
        for buildFilePath in glob.sync('./build/*(styles|components)/**/*')
            changedFiles.push fs.realpathSync buildFilePath

        # clear cache
        cache = Module._cache
        for file in changedFiles
            delete cache[file]

        # run build
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
        # do nothing on internal watcher error
        if event is 'error'
            return

        # always rebuild on directory changes
        unless event in ['addDir', 'unlinkDir']
            # always rebuild on file removed
            if event is 'unlink'
                delete files[path]
            else
                # do nothing when file has not been modified
                file = moduleCache.getFile path
                if files[path] is file
                    return
                files[path] = file

        # add to changed files
        if event is 'change'
            changedFiles.push fs.realpathSync path

        # request build
        unless isWaiting
            setTimeout update, 200
            isWaiting = true
        return
