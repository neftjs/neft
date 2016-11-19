'use strict'

pathUtils = require 'path'
fs = require 'fs-extra'
Mustache = require 'mustache'
coffee = require 'coffee-script'
cp = require 'child_process'

{utils, log} = Neft

OUT_DIR = './build/android/'
NATIVE_OUT_DIR = "#{OUT_DIR}app/src/main/java/io/neft/"
EXT_NATIVE_OUT_DIR = "#{NATIVE_OUT_DIR}extensions/"
CUSTOM_NATIVE_DIR = './native/android'
CUSTOM_NATIVE_OUT_DIR = "#{NATIVE_OUT_DIR}customapp/"
STATIC_DIR = './static'
STATIC_OUT_DIR = "#{OUT_DIR}app/src/main/assets/static"
BUNDLE_DIR = './build/android/'
RUNTIME_PATH = pathUtils.resolve __dirname, '../../../../../runtimes/android'

mustacheFiles = []

prepareFiles = (config) ->
    logtime = log.time 'Prepare android files'
    for path in mustacheFiles
        # get file
        file = fs.readFileSync path, 'utf-8'

        # get proper relative path
        relativePath = pathUtils.relative RUNTIME_PATH, path
        relativePath = relativePath.slice 0, -'.mustache'.length

        # compile coffee files
        if /\.coffee$/.test(relativePath)
            file = coffee.compile file
            relativePath = relativePath.slice 0, -'.coffee'.length
            relativePath += '.js'

        # render file
        file = Mustache.render file, config

        # save file
        fs.writeFileSync pathUtils.join(OUT_DIR, relativePath), file, 'utf-8'

    log.end logtime

module.exports = (config, callback) ->
    if config.buildBundleOnly
        prepareFiles config
        return callback()

    # check whether android sdk dir is specified
    if config.local.android.sdkDir is '$ANDROID_HOME'
        sdkDir = (cp.execSync('echo $ANDROID_HOME') + '').trim()
        unless config.local.android.sdkDir = sdkDir
            log.error "Specify Android SDK directory in 'local.json'"
            return

    logtime = log.time "Copy android files into '#{OUT_DIR}'"
    if fs.existsSync(OUT_DIR)
        fs.removeSync OUT_DIR
    fs.copySync RUNTIME_PATH, OUT_DIR,
        filter: (path) ->
            # omit hidden files
            if /\/\./i.test(path)
                return false
            # process mustache files later
            if /\.mustache$/.test(path)
                mustacheFiles.push path
                return false
            true
    log.end logtime

    if fs.existsSync(CUSTOM_NATIVE_DIR)
        logtime = log.time "Copy custom native files into `#{CUSTOM_NATIVE_OUT_DIR}`"
        fs.copySync CUSTOM_NATIVE_DIR, CUSTOM_NATIVE_OUT_DIR
        log.end logtime

    if fs.existsSync(STATIC_DIR)
        logtime = log.time "Copy static files into '#{STATIC_OUT_DIR}'"
        fs.copySync STATIC_DIR, STATIC_OUT_DIR
        if fs.existsSync('./build/static')
            fs.copySync './build/static', STATIC_OUT_DIR
        log.end logtime

    logtime = log.time 'Copy extensions'
    config.androidExtensions = []
    for ext in config.allExtensions
        nativeDirPath = "#{ext.path}/native/android"
        if fs.existsSync(nativeDirPath)
            name = utils.capitalize ext.name
            name = name.replace /(\-\w)/g, (m) -> m[1].toUpperCase()
            packageName = name.toLowerCase()
            config.androidExtensions.push
                name: name
                packageName: packageName
            fs.copySync nativeDirPath, "#{EXT_NATIVE_OUT_DIR}#{packageName}"
    log.end logtime

    prepareFiles config

    # main activity
    androidPackagePath = config.package.android.package.replace /\./g, '/'
    classFrom = "#{BUNDLE_DIR}app/src/main/java/__MainActivity__.java"
    classTo = "#{BUNDLE_DIR}app/src/main/java/#{androidPackagePath}/MainActivity.java"
    fs.move classFrom, classTo, (err) ->
        if err
            return callback err

        logtime = log.time 'Create android APK file'
        apkMode = if config.release then 'release' else 'debug'
        gradlewMode = 'assembleDebug'
        if /^win/.test(process.platform)
            exec = "cd #{BUNDLE_DIR} && ./gradlew.bat #{gradlewMode}"
        else
            exec = "cd #{BUNDLE_DIR} && chmod +x gradlew && ./gradlew #{gradlewMode}"
        gradleProcess = cp.exec exec, (err) ->
            log.end logtime
            callback err
        gradleProcess.stdout.pipe process.stdout
