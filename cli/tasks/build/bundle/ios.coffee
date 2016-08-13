'use strict'

pathUtils = require 'path'
fs = require 'fs-extra'
Mustache = require 'mustache'
coffee = require 'coffee-script'
cp = require 'child_process'
pathUtils = require 'path'
xcode = require 'xcode'

OUT_DIR = './build/ios/'
EXT_NATIVE_OUT_DIR = "#{OUT_DIR}Neft/Extension/"
CUSTOM_NATIVE_DIR = './native/ios'
CUSTOM_NATIVE_OUT_DIR = "#{OUT_DIR}Neft/"
STATIC_DIR = './static'
STATIC_OUT_DIR = "#{OUT_DIR}static"
ANDROID_BUNDLE_DIR = './build/ios/'
XCODE_PROJECT_PATH = "#{OUT_DIR}Neft.xcodeproj/project.pbxproj"

{utils, log} = Neft

module.exports = (config, callback) ->
    iosRuntimePath = pathUtils.resolve __dirname, '../../../../runtimes/ios'

    mustacheFiles = []
    coffeeFiles = []

    logtime = log.time "Copy ios files into '#{OUT_DIR}'"
    if fs.existsSync(OUT_DIR)
        fs.removeSync OUT_DIR
    fs.copySync iosRuntimePath, OUT_DIR,
        filter: (path) ->
            # omit hidden files
            if /\/\./i.test(path)
                return false
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
        log.error "Custom fonts are not supported. Install 'lcdf-typetools'; e.g. brew install lcdf-typetools"

    config.fonts = []
    if fs.existsSync(STATIC_DIR)
        logtime = log.time "Copy static files into '#{STATIC_OUT_DIR}'"
        fs.copySync STATIC_DIR, STATIC_OUT_DIR,
            filter: (path) ->
                # get font PostScript name
                if checkFonts and pathUtils.extname(path) in ['.otf', '.ttf']
                    realpath = fs.realpathSync(path)
                    name = (cp.execSync("otfinfo -p #{realpath}")+"").trim()
                    config.fonts.push
                        source: "/#{path}"
                        name: name
                true
        if fs.existsSync('./build/static')
            fs.copySync './build/static', STATIC_OUT_DIR
        log.end logtime

    logtime = log.time "Copy extensions"
    config.iosExtensions = []
    for ext in config.extensions
        nativeDirPath = "#{ext.path}native/ios"
        if fs.existsSync(nativeDirPath)
            name = utils.capitalize ext.name
            config.iosExtensions.push
                name: name
                path: nativeDirPath
                bundlePath: bundlePath = "#{EXT_NATIVE_OUT_DIR}#{name}"
            fs.copySync nativeDirPath, bundlePath
    log.end logtime

    logtime = log.time "Prepare ios files"
    for path in mustacheFiles
        # get file
        file = fs.readFileSync path, 'utf-8'

        # get proper relative path
        relativePath = pathUtils.relative iosRuntimePath, path
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

    for path in coffeeFiles
        # get file
        file = fs.readFileSync path, 'utf-8'

        # get proper relative path
        relativePath = pathUtils.relative iosRuntimePath, path

        # compile coffee files
        file = coffee.compile file
        relativePath = relativePath.slice 0, -'.coffee'.length
        relativePath += '.js'

        # save file
        fs.writeFileSync pathUtils.join(OUT_DIR, relativePath), file, 'utf-8'

    project = xcode.project XCODE_PROJECT_PATH
    project.parse (err) ->
        if err?
            console.error "Can't parse XCode project; create an issue on GitHub: https://github.com/Neft-io/neft\n\n"+err
            log.end logtime
            callback new Error "Can't parse XCode file"
            return

        mainGroupId = project.findPBXGroupKey path: 'Neft'

        # add extensions
        for ext in config.iosExtensions
            baseExtDir = ext.bundlePath.slice OUT_DIR.length
            files = fs.readdirSync ext.path
            name = 'Extension'+ext.name

            extGroupId = project.pbxCreateGroup name, "Extension/#{ext.name}"
            project.addToPbxGroup extGroupId, mainGroupId

            for file in files
                project.addSourceFile file, null, extGroupId

        fs.writeFile XCODE_PROJECT_PATH, project.writeSync(), ->
            log.end logtime
            callback()

