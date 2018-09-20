'use strict'

pathUtils = require 'path'
glob = require 'glob'
log = require 'src/log'
utils = require 'src/utils'
moduleCache = require 'lib/module-cache'
appBundleBuilder = require './appBundleBuilder'

log = log.scope 'hot-reloader'

MAIN_STAT_FOLDERS = ['styles']

BUILD_STAT_FOLDERS = ['components', 'scripts', 'styles']

SUPPORTED_FOLDERS =
    components: true
    styles: true
    scripts: true

FOLDERS_WITH_REQUIRES =
    styles: true
    scripts: true

HOT_RELOADS_ORDER =
    components: 1
    styles: 2
    scripts: 0

DISABLED_FILES =
    'styles/__windowItem__.nml': true

getRelativePath = (options, path) ->
    rel = pathUtils.relative options.cwd, path
    if rel.startsWith('build')
        rel = pathUtils.relative './build', rel
    rel

getPathFolder = (path) ->
    path.slice 0, path.indexOf(pathUtils.sep)

getStatPath = (cwd, folders, dir = '') ->
    pathUtils.join(cwd, dir, "*(#{folders.join('|')})", '**/*.?(js|nml)')

exports.canUse = (platform, options, result) ->
    if options.disableHotReloader
        return false

    # srcChangedFiles
    unless srcChangedFiles = options.srcChangedFiles
        return false
    for path in srcChangedFiles
        relPath = pathUtils.relative options.cwd, path
        folder = relPath.slice 0, relPath.indexOf(pathUtils.sep)
        unless SUPPORTED_FOLDERS[folder]
            return false

    # destChangedFiles
    unless destChangedFiles = result.destChangedFiles
        return false
    for path in destChangedFiles
        relPath = getRelativePath options, path
        folder = getPathFolder relPath
        unless SUPPORTED_FOLDERS[folder]
            return false
        if DISABLED_FILES[relPath]
            return false

    true

exports.prepare = (options, result, callback) ->
    buildGlob = getStatPath(options.cwd, BUILD_STAT_FOLDERS, 'build')
    mainGlob = getStatPath(options.cwd, MAIN_STAT_FOLDERS)

    globPath = "{#{buildGlob},#{mainGlob}}"
    glob globPath, (err, paths) ->
        {stats} = result
        if err
            return callback err
        promises = paths.map (path) ->
            moduleCache.fileHash(path)
                .then((hash) -> stats[path] = hash)
                .catch(callback)

        Promise.all(promises).then ->
            if options.lastResult
                {destChangedFiles} = result
                lastStats = options.lastResult.stats
                for key, val of stats
                    if val isnt lastStats[key]
                        destChangedFiles.push key

            callback()

exports.resolve = (platform, options, result, callback) ->
    {hotReloads} = result
    log.info "Preparing hot reload for `#{platform}`"
    stack = new utils.async.Stack

    appendHotReload = (path, callback) ->
        relPath = getRelativePath options, path
        folder = getPathFolder relPath
        name = relPath.slice folder.length + 1, relPath.lastIndexOf('.')
        file = moduleCache.getFileSync path

        if FOLDERS_WITH_REQUIRES[folder]
            appBundleBuilder
                platform: platform
                path: path
                basepath: options.cwd
                watch: true
                changedFiles: options.changedFiles
                onlyIndex: true
                , (err, file) ->
                    if err
                        return callback err
                    hotReloads.push
                        destination: folder
                        name: name
                        file: file
                    callback()
        else
            hotReloads.push
                destination: folder
                name: name
                file: file
            callback()

    for path in result.destChangedFiles
        stack.add appendHotReload, null, [path]

    stack.runAll (err) ->
        hotReloads.sort (a, b) ->
            HOT_RELOADS_ORDER[a.destination] - HOT_RELOADS_ORDER[b.destination]
        callback err
