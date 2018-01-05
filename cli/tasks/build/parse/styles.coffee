'use strict'

moduleCache = require 'lib/module-cache'
moduleCache.registerTxt(['.pegjs'])

fs = require 'fs-extra'
pathUtils = require 'path'
coffee = require 'coffee-script'
glob = require 'glob'
utils = require 'src/utils'
log = require 'src/log'
Document = require 'src/document'
nmlParser = require 'src/nml-parser'

createBundle = nmlParser.bundle
cliUtils = require 'cli/utils'

IN_DIR = 'styles'
QUERIES = './build/styles/queries.json'
DEFAULT_STYLES = pathUtils.join __dirname, '/styles/default'
STYLE_EXT_NAMES = ['.nml']

getQueryPriority = (val) ->
    Document.Element.Tag.query.getSelectorCommandsLength val

queriesSortFunc = (a, b) ->
    b.dirPriority - a.dirPriority or
    getQueryPriority(a.query) - getQueryPriority(b.query)

getInputDirs = (app) ->
    inputDirs = []

    for ext in app.allExtensions
        path = pathUtils.join ext.path, '/styles'
        if fs.existsSync(path)
            inputDirs.unshift path: path, prefix: "#{ext.name}/"

    # main styles folder
    inputDirs.push {path: IN_DIR, prefix: ''}

    # use default __windowItem__ if needed
    isMainViewExists = false
    for ext in STYLE_EXT_NAMES
        if isMainViewExists = fs.existsSync(pathUtils.join(IN_DIR, '/__windowItem__' + ext))
            break
    unless isMainViewExists
        inputDirs.push {path: DEFAULT_STYLES, prefix: ''}

    inputDirs

module.exports = (platform, app, callback) ->
    logLine = log.line().timer().loading 'Find styles'

    inputDirs = getInputDirs app
    filesToLoad = 0
    files = []
    filesByFilename = {}
    filesByDestPaths = {}

    inputDirPriorities = {}

    for dir, i in inputDirs then do (dir) ->
        if dir.prefix
            inputDirPriorities[dir.prefix] = i
        filesToLoad++
        cliUtils.forEachFileDeep dir.path, (path, stat) ->
            unless pathUtils.extname(path) in STYLE_EXT_NAMES
                return

            filesToLoad++

            filename = dir.prefix + path.slice(dir.path.length + 1, path.lastIndexOf('.'))

            files.push file =
                dir: dir
                filename: filename
                path: path
            filesByFilename[filename] = file

            if files.length is filesToLoad
                onFilesReady()
        , ->
            filesToLoad--
            if files.length is filesToLoad
                onFilesReady()

    onFilesReady = ->
        logLine.progress 'Parse styles', 0, files.length

        queries = {}

        for file in files
            try
                bundle = require file.path
                file.queries = bundle._queries
            catch err
                log.error "\u001b[1mError in `#{file.path}`\u001b[22m\n\n#{err.message or err}"
                return callback new Error "Cannot parse #{file.path} style file"
            queries[file.filename] = file.queries

            app.styles.push
                name: file.filename
                path: file.path

            logLine.progress 'Parse styles', app.styles.length, files.length

        # queries
        logLine.info 'Merge style queries'
        mergeQueries = ->
            for filename, fileQueries of queries
                unless cliUtils.isPlatformFilePath(platform, filename)
                    continue

                dirPriority = do ->
                    for dir, dirPriority of inputDirPriorities
                        if filename.indexOf(dir) is 0
                            return dirPriority
                    return 0

                for query, val of fileQueries
                    val = "styles:#{filename}:#{val}"

                    splitQuery = query.split ','
                    for query in splitQuery
                        app.styleQueries.push
                            query: query
                            style: val
                            dirPriority: dirPriority

            # sort queries
            app.styleQueries.sort queriesSortFunc

            queriesJson = JSON.stringify queries, null, 4
            fs.outputFile QUERIES, queriesJson, callback
            logLine.ok "Styles parsed _(#{files.length} files)_"

        mergeQueries()
        return
