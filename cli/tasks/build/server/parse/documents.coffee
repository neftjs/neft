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

IN_DIR = 'components'
OUT_DIR = 'build'
SCRIPTS_DIR = './build/scripts'
STYLES_DIR = './build/styles/_components'

Document.FILES_PATH = IN_DIR
Document.SCRIPTS_PATH = SCRIPTS_DIR
Document.STYLES_PATH = STYLES_DIR
loadedExtensions = {}

class DocumentParseError extends Error
    constructor: (@message, @previousError) ->
        if @previousError
            @message += "\n\n#{@previousError.message}"

module.exports = (platform, app, callback) ->
    unless fs.existsSync(IN_DIR)
        return callback null

    logtime = log.time 'Parse documents'

    parsingError = null

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
        app.styles.push
            name: style.filename
            path: style.path
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
            msg = "Cannot parse file '#{path}'\n#{error.message}"
            parsingError = new DocumentParseError msg, parsingError
            return
        file

    saveComponent = (name, component, callback) ->
        json = JSON.stringify component
        json = "module.exports = #{json}"
        path = "#{OUT_DIR}/#{name}.js"
        app.components.push {name, path}
        fs.outputFile path, json, 'utf-8', callback
        return

    onFilesParsed = ->
        stack = new utils.async.Stack

        for name, component of Document._files
            stack.add saveComponent, null, [name, component]

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
        callback parsingError
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
