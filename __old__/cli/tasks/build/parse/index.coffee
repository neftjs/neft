'use strict'

fs = require 'fs'
cliUtils = require 'cli/utils'
pathUtils = require 'path'
glob = require 'glob'
slash = require 'slash'

utils = require 'src/utils'
log = require 'src/log'

HOT_RELOADER_FILE_PATH = pathUtils.join __dirname, '..', 'appHotReloader'
ERROR_POPUP_FILE_PATH = pathUtils.join __dirname, '..', 'errorPopup', 'index'

CONFIG_LINKS_TO_REQUIRE =
    components: true
    styles: true
    routes: true
    scripts: true

###
Prepares index file
###
module.exports = (platform, app, options) ->
    stringifyLink = (obj) ->
        unless utils.isObject(obj)
            return obj

        {path} = obj
        unless cliUtils.isPlatformFilePath(platform, path)
            return false

        obj.path = undefined
        val = "`require('#{path}')`"
        obj.file = val
        return true

    jsonReplacer = (key, val) ->
        if CONFIG_LINKS_TO_REQUIRE[key]
            i = 0
            while i < val.length
                if stringifyLink(val[i])
                    i++
                else
                    val.splice i, 1
        val

    # include app extensions
    for ext in app.allExtensions
        path = pathUtils.join ext.path, '/init.js'
        if fs.existsSync(path)
            app.extensions.push "`require('#{path}')`"

    # get 'package.json' config
    app.config = app.package.config or {}

    # include custom config
    if options.config
        utils.merge app.config, JSON.parse(options.config)

    # parse app into object
    config = JSON.stringify app, jsonReplacer
    config = config.replace ///"`///g, ''
    config = config.replace ///`"///g, ''

    # create file
    file = ''
    file += "require('babel-polyfill');\n"
    file += "Neft.eventLoop.lock()\n"

    if fs.existsSync(options.initFile)
        initFilePath = options.initFile
        unless pathUtils.isAbsolute(initFilePath)
            initFilePath = pathUtils.join '..', initFilePath
        file += "var init = require('#{slash initFilePath}');\n"
        file += "var opts = #{config};\n"
        file += 'module.exports = init(Neft.bind(null, opts));\n'
    else
        file += "var opts = #{config};\n"
        file += 'module.exports = Neft(opts);\n'
    if options.watch
        file += "require('#{slash HOT_RELOADER_FILE_PATH}')(module.exports);\n"
    unless options.release
        file += "require('#{slash ERROR_POPUP_FILE_PATH}')(module.exports);\n"
    file += "Neft.eventLoop.release();\n"

    file
