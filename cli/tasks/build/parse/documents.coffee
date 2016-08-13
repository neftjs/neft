'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
coffee = require 'coffee-script'

cliUtils = require 'cli/utils'

{utils, log, Document, styles, signal} = Neft

IN_DIR = 'views'
OUT_DIR = 'build'

Document.FILES_PATH = IN_DIR
loadedExtensions = {}

module.exports = (platform, app, callback) ->
    logtime = log.time 'Parse documents'

    fs.removeSync pathUtils.join(OUT_DIR, IN_DIR)

    # install document extensions
    packageConfig = JSON.parse fs.readFileSync('./package.json')
    realpath = fs.realpathSync '.'
    for key of packageConfig.dependencies
        if /^neft\-document\-/.test(key) and not loadedExtensions[key]
            loadedExtensions[key] = true
            require(pathUtils.join(realpath, '/node_modules/', key))()

    styles {windowStyle: null, styles: {}, queries: app.styleQueries}
    utils.clear Document._files

    Document.onError onErrorListener = (name) ->
        parseFile name

    Document.onBeforeParse onBeforeParseListener = (file) ->
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
        html = fs.readFileSync path, 'utf-8'
        file = Document.fromHTML path, html
        Document.parse file
        file

    saveView = (name, view, callback) ->
        json = JSON.stringify view
        json = "module.exports = #{json}"
        path = "#{OUT_DIR}/#{name}.js"
        app.views.push { name, path }
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

        Document.onError.disconnect onErrorListener
        Document.onBeforeParse.disconnect onBeforeParseListener
        Document.onParse.disconnect onParseListener
        Document.onStyle.disconnect onStyleListener

        log.end logtime
        callback null
        return

    cliUtils.forEachFileDeep IN_DIR, (path, stat) ->
        if /\..*ml$/.test(path) and not Document._files[path]
            parseFile path
    , (err) ->
        if err
            log.end logtime
            return callback err
        onFilesParsed()
