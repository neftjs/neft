'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
coffee = require 'coffee-script'

cliUtils = require 'cli/utils'

{utils, log, Document, styles, signal} = Neft

IN_DIR = 'views'
OUT_DIR = 'build'
SCRIPTS_DIR = './build/scripts'

Document.FILES_PATH = IN_DIR
Document.SCRIPTS_PATH = "#{SCRIPTS_DIR}/#{utils.uid()}/"
loadedExtensions = {}

module.exports = (platform, app, callback) ->
    logtime = log.time 'Parse documents'

    # install document extensions
    packageConfig = JSON.parse fs.readFileSync('./package.json')
    realpath = fs.realpathSync '.'
    for key of packageConfig.dependencies
        if /^neft\-document\-/.test(key) and not loadedExtensions[key]
            loadedExtensions[key] = true
            require(pathUtils.join(realpath, '/node_modules/', key))()

    styles {windowStyle: null, styles: {}, queries: app.styleQueries}
    utils.clear Document._files
    mainPaths = Object.create null

    Document.onError onErrorListener = (path) ->
        mainPaths[path] = true
        parseFile path

    Document.onBeforeParse onBeforeParseListener = (file) ->
        if mainPaths[file.path]
            Document.Style.applyStyleQueriesInDocument file
        return

    Document.onParse onParseListener = (file) ->
        Document.Style.createStylesInDocument file
        return

    Document.onStyle onStyleListener = (style) ->
        destPath = pathUtils.join 'build/styles/_views/', style.path
        data = coffee.compile style.data
        fs.outputFileSync destPath, data
        style.destPath = destPath
        app.styles.push
            name: style.filename
            path: destPath
        return

    parseFile = (path) ->
        try
            html = fs.readFileSync path, 'utf-8'
        catch
            log.error "File `#{path}` doesn't exist"
            return
        file = Document.fromHTML path, html
        try
            Document.parse file
        catch error
            log.error "File `#{path}` can't be parsed: #{error}"
            return
        file

    saveView = (name, view, callback) ->
        json = JSON.stringify view
        json = "module.exports = #{json}"
        path = "#{OUT_DIR}/#{name}.js"
        app.views.push {name, path}
        fs.outputFile path, json, 'utf-8', callback
        return

    onFilesParsed = ->
        stack = new utils.async.Stack

        for name, view of Document._files
            stack.add saveView, null, [name, view]

        stack.runAllSimultaneously onViewsSaved

    onViewsSaved = (err) ->
        if err
            return callback err

        # clear listeners
        Document.onError.disconnect onErrorListener
        Document.onBeforeParse.disconnect onBeforeParseListener
        Document.onParse.disconnect onParseListener
        Document.onStyle.disconnect onStyleListener

        # move scripts as build scripts
        fs.ensureDirSync Document.SCRIPTS_PATH
        fs.copySync Document.SCRIPTS_PATH, SCRIPTS_DIR
        fs.removeSync Document.SCRIPTS_PATH
        log.end logtime
        callback err
        return

    cliUtils.forEachFileDeep IN_DIR, (path, stat) ->
        if /\..*ml$/.test(path) and not Document._files[path]
            mainPaths[path] = true
            parseFile path
    , (err) ->
        if err
            log.end logtime
            return callback err
        onFilesParsed()