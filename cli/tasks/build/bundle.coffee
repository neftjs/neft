'use strict'

fs = require 'fs'
bundleBuilder = require 'src/bundle-builder'
pathUtils = require 'path'

{utils, log} = Neft

DEFAULT_LOCAL_FILE =
    android:
        sdkDir: '$ANDROID_HOME'
        compileSdkVersion: 23
        buildToolsVersion: "23"
        dependencies: [
            "com.android.support:appcompat-v7:23.0.0"
        ]

module.exports = (platform, options, app, callback) ->
    mode = if options.release then 'release' else 'develop'
    neftFileName = "neft-#{platform}-#{mode}.js"
    neftFilePath = "../../bundle/neft-#{platform}-#{mode}.js"

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
                modulePath.indexOf('..') isnt 0 or
                modulePath.indexOf('node_modules') is -1

    bundleBuilder
        path: 'index.js'
        verbose: true
        platform: platform
        release: options.release
        minify: options.release
        removeLogs: options.release
        neftFilePath: pathUtils.resolve(__dirname, neftFilePath)
        testResolved: testResolvedFunc
        useBabel: true
        , (err, file) ->
            if err
                return callback err

            if fs.existsSync('./local.json')
                localFile = JSON.parse fs.readFileSync './local.json', 'utf-8'
                local = {}
                utils.mergeDeep local, DEFAULT_LOCAL_FILE
                utils.mergeDeep local, localFile
            else
                local = DEFAULT_LOCAL_FILE
            fs.writeFileSync './local.json', JSON.stringify(local, null, 4)

            config =
                platform: platform
                release: options.release
                app: app
                mode: mode
                neftFileName: neftFileName
                neftCode: fs.readFileSync pathUtils.resolve(__dirname, neftFilePath), 'utf-8'
                appFileName: "app-#{platform}-#{mode}.js"
                appCode: file
                package: JSON.parse fs.readFileSync('./package.json')
                local: JSON.parse fs.readFileSync('./local.json')
                extensions: []

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
