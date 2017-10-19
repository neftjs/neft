'use strict'

fs = require 'fs'
pathUtils = require 'path'
Module = require 'module'
bundleBuilder = require 'lib/bundle-builder'
utils = require 'src/utils'
signal = require 'src/signal'

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

testFunc = (req, filename) ->
    not isInternalDependency filename or req

module.exports = (opts, callback) ->
    mode = if opts.release then 'release' else 'develop'
    neftFilePath = pathUtils.resolve __dirname, "../../../bundle/neft-#{opts.platform}-#{mode}.js"

    onEnvPrepare = signal.create()
    onEnvPrepare.connect -> mockNeft opts.platform, neftFilePath

    builderOpts = utils.clone opts
    utils.merge builderOpts,
        test: testFunc
        testResolved: testFunc
        onEnvPrepare: onEnvPrepare

    bundleBuilder builderOpts, (err, file) ->
        global.Neft = NEFT
        callback err, file
