'use strict'

fs = require 'fs'
appBundleBuilder = require './appBundleBuilder'
pathUtils = require 'path'
log = require 'src/log'

INDEX_PATH = 'build/index.js'
INDEX_ABS_PATH = pathUtils.resolve fs.realpathSync('.'), INDEX_PATH

module.exports = (platform, options, app, callback) ->
    mode = if options.release then 'release' else 'develop'
    neftFileName = "neft-#{platform}-#{mode}.js"
    neftFilePath = pathUtils.resolve __dirname, "../../bundle/neft-#{platform}-#{mode}.js"

    logLine = log.line().timer().repeat().loading 'Creating bundle...'

    # prepare config
    if options.watch
        changedFiles = []
        changedFiles.push options.changedFiles...
        changedFiles.push INDEX_ABS_PATH

    # build bundle
    appBundleBuilder
        platform: platform
        path: INDEX_PATH
        release: options.release
        minify: options.release
        removeLogs: options.release
        watch: options.watch
        changedFiles: changedFiles
        basepath: options.cwd
        , (err, file) ->
            if err
                logLine.error 'Cannot create bundle'
                logLine.stop()
                return callback err

            # make app object global in the file scope
            file = "var app = #{file};\n"

            config =
                platform: platform
                release: options.release
                debug: not options.release
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

            platformBundle = require "./bundle/#{platform}"
            platformBundle config, (err) ->
                if err
                    logLine.error 'Cannot create bundle'
                else
                    logLine.ok 'Bundle created'
                logLine.stop()
                callback err
