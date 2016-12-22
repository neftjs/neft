'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
coffee = require 'coffee-script'

cliUtils = require 'cli/utils'
utils = require 'src/utils'
log = require 'src/log'
Document = require 'src/document'
styles = require 'src/styles'
signal = require 'src/signal'

IN_DIR = 'views'
OUT_DIR = 'build'
SCRIPTS_DIR = './build/scripts'

Document.FILES_PATH = IN_DIR
Document.SCRIPTS_PATH = SCRIPTS_DIR
loadedExtensions = {}

module.exports = (platform, app, callback) ->
    unless fs.existsSync(IN_DIR)
        return callback null

    logtime = log.time 'Parse documents'

    # clear
    fs.removeSync "./#{OUT_DIR}/#{IN_DIR}"
    fs.removeSync SCRIPTS_DIR

    # install document extensions
    for ext in app.allExtensions
        path = pathUtils.join ext.path, '/app.js'
        if not loadedExtensions[ext.name] and fs.existsSync(path)
            loadedExtensions[ext.name] = true
            require(path)()

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
