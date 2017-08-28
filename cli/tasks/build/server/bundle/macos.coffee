'use strict'

pathUtils = require 'path'
fs = require 'fs-extra'
Mustache = require 'mustache'
coffee = require 'coffee-script'
cp = require 'child_process'
pathUtils = require 'path'
xcode = require 'xcode'

OUT_DIR = './build/macos/'
EXT_NATIVE_OUT_DIR = "#{OUT_DIR}io.neft.mac/Extension/"
CUSTOM_NATIVE_DIR = './native/macos'
CUSTOM_NATIVE_OUT_DIR = "#{OUT_DIR}io.neft.mac/"
STATIC_DIR = './static'
STATIC_OUT_DIR = "#{OUT_DIR}static"
ANDROID_BUNDLE_DIR = './build/macos/'
XCODE_PROJECT_PATH = "#{OUT_DIR}io.neft.mac.xcodeproj/project.pbxproj"
RUNTIME_PATH = pathUtils.resolve __dirname, '../../../../../runtimes/macos'

{utils, log} = Neft

mustacheFiles = []
coffeeFiles = []

prepareFiles = (config) ->
    logtime = log.time 'Prepare macos files'

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
        else if config.buildBundleOnly
            continue

        # render file
        file = Mustache.render file, config

        # save file
        fs.writeFileSync pathUtils.join(OUT_DIR, relativePath), file, 'utf-8'

    for path in coffeeFiles
        # get file
        file = fs.readFileSync path, 'utf-8'

        # get proper relative path
        relativePath = pathUtils.relative RUNTIME_PATH, path

        # compile coffee files
        file = coffee.compile file
        relativePath = relativePath.slice 0, -'.coffee'.length
        relativePath += '.js'

        # save file
        fs.writeFileSync pathUtils.join(OUT_DIR, relativePath), file, 'utf-8'
    log.end logtime

module.exports = (config, callback) ->
    if config.buildBundleOnly
        prepareFiles config
        return callback()

    logtime = log.time "Copy macos files into '#{OUT_DIR}'"
    if fs.existsSync(OUT_DIR)
        fs.removeSync OUT_DIR
    fs.copySync RUNTIME_PATH, OUT_DIR,
        filter: (path) ->
            # compile coffee files
            if /\.coffee$/.test(path)
                coffeeFiles.push path
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

    # check whether otfinfo is installed
    checkFonts = false
    try
        cp.execSync 'otfinfo --version', silent: true
        checkFonts = true
    catch
        log.error """
            Custom fonts are not supported. \
            Install 'lcdf-typetools'; \
            e.g. brew install lcdf-typetools
        """

    config.fonts = []
    if fs.existsSync(STATIC_DIR)
        logtime = log.time "Copy static files into '#{STATIC_OUT_DIR}'"
        fs.copySync STATIC_DIR, STATIC_OUT_DIR,
            filter: (path) ->
                # get font PostScript name
                if checkFonts and pathUtils.extname(path) in ['.otf', '.ttf']
                    realpath = fs.realpathSync(path)
                    name = (cp.execSync("otfinfo -p #{realpath}") + "").trim()
                    config.fonts.push
                        source: "/#{path}"
                        name: name
                true
        if fs.existsSync('./build/static')
            fs.copySync './build/static', STATIC_OUT_DIR
        log.end logtime
    else
        fs.ensureDirSync STATIC_OUT_DIR

    logtime = log.time 'Copy extensions'
    config.macosExtensions = []
    for ext in config.allExtensions
        nativeDirPath = "#{ext.path}/native/macos"
        if fs.existsSync(nativeDirPath)
            name = utils.capitalize ext.name
            name = name.replace /(\-\w)/g, (m) -> m[1].toUpperCase()
            config.macosExtensions.push
                name: name
                path: nativeDirPath
                bundlePath: bundlePath = "#{EXT_NATIVE_OUT_DIR}#{name}"
            fs.copySync nativeDirPath, bundlePath
    log.end logtime

    prepareFiles config

    logtime = log.time 'Prepare XCode project'
    project = xcode.project XCODE_PROJECT_PATH
    project.parse (err) ->
        if err?
            log.error "Can't parse XCode project"
            log.error err?.stack or err
            log.end logtime
            callback new Error "Can't parse XCode file"
            return

        mainGroupId = project.findPBXGroupKey path: 'io.neft.mac'

        # add extensions
        for ext in config.macosExtensions
            baseExtDir = ext.bundlePath.slice OUT_DIR.length
            files = fs.readdirSync ext.path
            name = 'Extension' + ext.name

            extGroupId = project.pbxCreateGroup name, "Extension/#{ext.name}"
            project.addToPbxGroup extGroupId, mainGroupId

            for file in files
                project.addSourceFile file, null, extGroupId

        fs.writeFile XCODE_PROJECT_PATH, project.writeSync(), ->
            log.end logtime
            callback()