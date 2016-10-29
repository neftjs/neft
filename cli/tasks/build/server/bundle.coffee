'use strict'

fs = require 'fs'
bundleBuilder = require 'lib/bundle-builder'
pathUtils = require 'path'
coffee = require 'coffee-script'
Mustache = require 'mustache'
Module = require 'module'

{utils, log, signal} = Neft

INDEX_PATH = 'build/index.js'
INDEX_ABS_PATH = pathUtils.resolve fs.realpathSync('.'), INDEX_PATH

NEFT = Neft
MOCK_NEFT = Object.create null

mockNeft = (platform, neftFilePath) ->
    if global.Neft = MOCK_NEFT[platform]
        return

    # mock Neft and disable app
    module = new Module neftFilePath
    module.load neftFilePath
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
        utils.isNode = utils.isServer = utils.isClient =
        utils.isBrowser = utils.isAndroid = utils.isIOS = false
        switch platform
            when 'node'
                utils.isNode = true
                utils.isServer = true
            when 'browser'
                utils.isBrowser = true
                utils.isClient = true
            when 'android'
                utils.isAndroid = true
                utils.isClient = true
            when 'ios'
                utils.isIOS = true
                utils.isClient = true
    return

module.exports = (platform, options, app, callback) ->
    mode = if options.release then 'release' else 'develop'
    neftFileName = "neft-#{platform}-#{mode}.js"
    neftFilePath = pathUtils.resolve __dirname, "../../../bundle/neft-#{platform}-#{mode}.js"

    testResolvedFunc = do ->
        if platform is 'node' and options.out
            (req, path, modulePath, parentPath) ->
                modulePath.indexOf('node_modules') is -1 and
                (req isnt path or pathUtils.isAbsolute(req))
        else if platform is 'node'
            (req, path, modulePath, parentPath) ->
                req isnt path and modulePath.indexOf('node_modules') is -1
        else
            (req, path, modulePath, parentPath) ->
                true

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
        testResolved: testResolvedFunc
        onEnvPrepare: onEnvPrepare
        , (err, file) ->
            global.Neft = NEFT
            log.end logtime

            if err
                return callback err

            config =
                platform: platform
                release: options.release
                app: app
                mode: mode
                neftFileName: neftFileName
                neftCode: fs.readFileSync neftFilePath, 'utf-8'
                appFileName: "app-#{platform}-#{mode}.js"
                appCode: file
                package: JSON.parse fs.readFileSync('./package.json')
                local: JSON.parse fs.readFileSync('./local.json')
                extensions: []
                buildBundleOnly: !!options.buildBundleOnly
                buildServerUrl: options.buildServerUrl

            # get module extensions
            try
                modules = fs.readdirSync './node_modules'
                for path in modules
                    if /^neft\-/.test(path)
                        config.extensions.push
                            name: path.slice('neft-'.length)
                            path: "./node_modules/#{path}/"

            # get local extensions
            try
                extensions = fs.readdirSync './extensions'
                for path in extensions
                    config.extensions.push
                        name: path
                        path: "./extensions/#{path}/"

            require("./bundle/#{platform}") config, callback
