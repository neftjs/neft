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
ICON_DIR = './build/manifest/icons/android'
ICON_OUT_DIR = "#{OUT_DIR}app/src/main/res"
JS_FILE_PATH = "app/src/main/assets/javascript/neft.coffee.mustache"
BUNDLE_DIR = './build/android/'
RUNTIME_PATH = pathUtils.resolve __dirname, '../../../../runtimes/android'
APP_DIR = './manifest/android/app'
APP_OUT_DIR = './build/android/app'

mustacheFiles = []

processMustacheFile = (path, config) ->
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
    return

module.exports = (config, callback) ->
    if config.buildBundleOnly
        jsFilePath = fs.realpathSync pathUtils.join RUNTIME_PATH, JS_FILE_PATH
        processMustacheFile jsFilePath, config
        return callback()

    # check whether android sdk dir is specified
    if config.local.android.sdkDir is '$ANDROID_HOME'
        sdkDir = (cp.execSync('echo $ANDROID_HOME') + '').trim()
        unless config.local.android.sdkDir = sdkDir
            log.error "Specify Android SDK directory in `local.json`"
            callback new Error '$ANDROID_HOME not specified'
            return

    logLine = log.line().timer().loading "Copying android files into `#{OUT_DIR}`..."
    if fs.existsSync(OUT_DIR)
        fs.removeSync OUT_DIR
    fs.copySync RUNTIME_PATH, OUT_DIR,
        filter: (path) ->
            # process mustache files later
            if /\.mustache$/.test(path)
                mustacheFiles.push path
                return false
            true
    logLine.ok "Android files copied into `#{OUT_DIR}`"
    logLine.stop()

    if fs.existsSync(CUSTOM_NATIVE_DIR)
        logLine = log.line().timer().loading """
            Copying custom native files into `#{CUSTOM_NATIVE_OUT_DIR}`...
        """
        fs.copySync CUSTOM_NATIVE_DIR, CUSTOM_NATIVE_OUT_DIR
        logLine.ok "Custom native files copied into `#{CUSTOM_NATIVE_OUT_DIR}`"
        logLine.stop()

    if fs.existsSync(STATIC_DIR)
        logLine = log.line().timer().loading "Copying static files into `#{STATIC_OUT_DIR}`..."
        fs.copySync STATIC_DIR, STATIC_OUT_DIR
        if fs.existsSync('./build/static')
            fs.copySync './build/static', STATIC_OUT_DIR
        logLine.ok "Static files copied into `#{STATIC_OUT_DIR}`"
        logLine.stop()

    if fs.existsSync(ICON_DIR)
        logLine = log.line().timer().loading "Copying icon files into `#{ICON_OUT_DIR}`"
        fs.copySync ICON_DIR, ICON_OUT_DIR
        logLine.ok "Icons copied into `#{ICON_OUT_DIR}`"
        logLine.stop()

    if fs.existsSync(APP_DIR)
        logLine = log.line().timer().loading "Copying app files into `#{APP_OUT_DIR}`"
        fs.copySync APP_DIR, APP_OUT_DIR
        logLine.ok "App files copied into `#{APP_OUT_DIR}`"
        logLine.stop()

    logLine = log.line().timer().loading 'Copying extensions...'
    config.androidExtensions = []
    for ext in config.allExtensions
        nativeDirPath = "#{ext.path}/native/android"
        if fs.existsSync(nativeDirPath)
            name = utils.capitalize ext.name
            name = name.replace /(\-\w)/g, (m) -> m[1].toUpperCase()
            packageName = "#{name.toLowerCase()}_extension"
            config.androidExtensions.push
                name: name
                packageName: packageName
            fs.copySync nativeDirPath, "#{EXT_NATIVE_OUT_DIR}#{packageName}"
    logLine.ok 'Extensions copied'
    logLine.stop()

    logLine = log.line().timer().loading 'Preparing Android files...'
    for path in mustacheFiles
        processMustacheFile path, config
    logLine.ok 'Android files prepared'

    # main activity
    androidPackagePath = config.manifest.package.replace /\./g, '/'
    classFrom = "#{BUNDLE_DIR}app/src/main/java/__MainActivity__.java"
    classTo = "#{BUNDLE_DIR}app/src/main/java/#{androidPackagePath}/MainActivity.java"
    fs.move classFrom, classTo, (err) ->
        if err
            return callback err

        logLine = log.line().timer().repeat().loading 'Creating Android APK...'
        gradlewMode = if config.release then 'assembleRelease' else 'assembleDebug'
        if /^win/.test(process.platform)
            cmd = "./gradlew.bat #{gradlewMode} --quiet"
        else
            cmd = "chmod +x gradlew && ./gradlew #{gradlewMode} --quiet"
        gradleProcess = cp.exec cmd, cwd: BUNDLE_DIR, (err) ->
            if err
                logLine.error 'Cannot create Android SDK'
            else
                logLine.ok 'Android SDK created'
            logLine.stop()
            callback err
        gradleProcess.stdout.pipe process.stdout
