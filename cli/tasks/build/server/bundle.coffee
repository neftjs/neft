'use strict'

fs = require 'fs'
bundleBuilder = require 'lib/bundle-builder'
pathUtils = require 'path'
coffee = require 'coffee-script'
Mustache = require 'mustache'
Module = require 'module'
utils = require 'src/utils'
log = require 'src/log'
signal = require 'src/signal'

INDEX_PATH = 'build/index.js'
INDEX_ABS_PATH = pathUtils.resolve fs.realpathSync('.'), INDEX_PATH

NEFT = Neft
MOCK_NEFT = Object.create null

mockNeft = (platform, neftFilePath) ->
    if global.Neft = MOCK_NEFT[platform]
        return

    # mock Neft and disable app
    module = new Module neftFilePath
    moduleFile = fs.readFileSync neftFilePath, 'utf8'
    module._compile moduleFile, neftFilePath
    global.Neft = ->
    utils.merge Neft, module.exports
    MOCK_NEFT[platform] = Neft

    # disable unit tests
    do (unit = null) ->
        utils.defineProperty Neft, 'unit',
            utils.ENUMERABLE | utils.CONFIGURABLE,
            ->
                unit
            , (val) ->
                val.runAutomatically = false
                unit = Object.create val
                unit.runTests = ->

    # mock utils
    do (utils = Neft.utils) ->
        utils.isNode = utils.isServer = utils.isClient = utils.isNative =
        utils.isBrowser = utils.isAndroid = utils.isIOS = false
        switch platform
            when 'node'
                utils.isServer = utils.isNode = true
            when 'browser'
                utils.isClient = utils.isBrowser = true
            when 'webgl'
                utils.isClient = utils.isWebGL = true
            when 'android'
                utils.isNative = utils.isClient = utils.isAndroid = true
            when 'ios'
                utils.isNative = utils.isClient = utils.isIOS = true
            when 'macos'
                utils.isNative = utils.isClient = utils.isMacOS = true
    return

isInternalDependency = do ->
    PREFIX = fs.realpathSync pathUtils.join __dirname, '../../../../node_modules/'
    (filename) ->
        filename.indexOf(PREFIX) is 0

module.exports = (platform, options, app, callback) ->
    mode = if options.release then 'release' else 'develop'
    neftFileName = "neft-#{platform}-#{mode}.js"
    neftFilePath = pathUtils.resolve __dirname, "../../../bundle/neft-#{platform}-#{mode}.js"

    testFunc = (req, filename) ->
        not isInternalDependency filename or req

    logtime = log.time 'Resolve bundle modules'

    # prepare config
    if options.watch
        changedFiles = []
        changedFiles.push options.changedFiles...
        changedFiles.push INDEX_ABS_PATH

    onEnvPrepare = signal.create()
    onEnvPrepare.connect -> mockNeft platform, neftFilePath

    # build bundle
    bundleBuilder
        path: INDEX_PATH
        verbose: true
        platform: platform
        release: options.release
        minify: options.release
        removeLogs: options.release
        watch: options.watch
        changedFiles: changedFiles
        test: testFunc
        testResolved: testFunc
        onEnvPrepare: onEnvPrepare
        , (err, file) ->
            global.Neft = NEFT
            log.end logtime

            if err
                return callback err

            # make app object global in the file scope
            file = "var app = #{file};\n"

            config =
                platform: platform
                release: options.release
                debug: !options.release
                app: app
                mode: mode
                neftFileName: neftFileName
                neftCode: fs.readFileSync neftFilePath, 'utf-8'
                appFileName: "app-#{platform}-#{mode}.js"
                appCode: file
                package: app.package
                local: JSON.parse fs.readFileSync('./local.json')
                allExtensions: app.allExtensions
                extensions: app.extensions
                buildBundleOnly: !!options.buildBundleOnly
                buildServerUrl: options.buildServerUrl

            require("./bundle/#{platform}") config, callback
