'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
coffee = require 'coffee-script'

{utils, log, Document, nmlParser} = Neft

createBundle = nmlParser.bundle
cliUtils = require 'cli/utils'

IN_DIR = './styles'
OUT_DIR = 'build/styles'
QUERIES = './build/styles/queries.json'
DEFAULT_STYLES = pathUtils.join __dirname, '/styles/default'

getQueryPriority = (val) ->
    Document.Element.Tag.query.getSelectorCommandsLength val

queriesSortFunc = (a, b) ->
    b.dirPriority - a.dirPriority or
    getQueryPriority(a.query) - getQueryPriority(b.query)

writeFile = (path, data, callback) ->
    data = coffee.compile data, bare: true
    fs.outputFile path, data, callback

getInputDirs = (app) ->
    inputDirs = []

    for ext in app.allExtensions
        path = pathUtils.join ext.path, '/styles'
        if fs.existsSync(path)
            inputDirs.push path: path, prefix: "#{ext.name}/"

    # main styles folder
    inputDirs.push {path: IN_DIR, prefix: ''}

    # default __view__ if needed
    unless fs.existsSync(pathUtils.join(IN_DIR, '/__view__.js'))
        inputDirs.push {path: DEFAULT_STYLES, prefix: ''}

    inputDirs

module.exports = (platform, app, callback) ->
    fs.ensureDir OUT_DIR

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
            unless pathUtils.extname(path) in ['.js', '.nml']
                return

            filesToLoad++

            filename = dir.prefix + path.slice(dir.path.length+1)
            filename = filename.slice 0, filename.lastIndexOf('.')
            destPath = "#{OUT_DIR}/#{filename}.js"

            fs.stat destPath, (destErr, destStat) ->
                if destErr or (new Date(stat.mtime)).valueOf() > (new Date(destStat.mtime)).valueOf()
                    fs.readFile path, 'utf-8', (err, data) ->
                        if err
                            return callback err

                        files.push file =
                            dir: dir
                            filename: filename
                            path: path
                            destPath: destPath
                            data: data
                        filesByFilename[filename] = file

                        if files.length is filesToLoad
                            onFilesReady()
                else
                    files.push file =
                        filename: filename
                        path: path
                        destPath: destPath
                    filesByFilename[filename] = file

                    if files.length is filesToLoad
                        onFilesReady()
        , ->
            filesToLoad--
            if files.length is filesToLoad
                onFilesReady()

    onFilesReady = ->
        newQueries = {}
        stack = new utils.async.Stack

        for file in files
            if file.data?
                compileLogtime = log.time "Compile '#{file.path}'"
                try
                    createBundle file
                catch err
                    console.error "\u001b[1mError in `#{file.path}`\u001b[22m\n\n#{err.message or err}"
                    log.end compileLogtime
                    continue
                log.end compileLogtime
                newQueries[file.filename] = file.queries
                stack.add writeFile, null, [file.destPath, file.data]

            app.styles.push
                name: ///^build/styles/(.+)\.[a-z]+$///.exec(file.destPath)[1]
                path: file.destPath

        # queries
        writeLogtime = log.time 'Save styles'
        stack.runAllSimultaneously (err) ->
            log.end writeLogtime

            if err
                return callback err

            currentQueries = null
            mergeQueries = ->
                utils.merge currentQueries, newQueries

                for filename, fileQueries of currentQueries
                    unless cliUtils.isPlatformFilePath(platform, "#{filename}.js")
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

                queriesJson = JSON.stringify currentQueries, null, 4
                fs.writeFile QUERIES, queriesJson, callback

            fs.exists QUERIES, (exists) ->
                if exists
                    fs.readFile QUERIES, (err, json) ->
                        if err?
                            return callback err
                        currentQueries = JSON.parse json

                        # remove abandoned files queries
                        for filename of currentQueries
                            unless filesByFilename[filename]
                                delete currentQueries[filename]

                        mergeQueries()
                else
                    currentQueries = {}
                    mergeQueries()
                return
            return
