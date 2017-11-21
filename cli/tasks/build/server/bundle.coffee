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
    neftFilePath = pathUtils.resolve __dirname, "../../../bundle/neft-#{platform}-#{mode}.js"

    logtime = log.time 'Resolve bundle modules'

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
            log.end logtime

            if err
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
            log.show ''
            platformBundle config, callback
