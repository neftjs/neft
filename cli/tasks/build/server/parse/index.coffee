'use strict'

fs = require 'fs'
cliUtils = require 'cli/utils'
pathUtils = require 'path'
glob = require 'glob'

utils = require 'src/utils'
log = require 'src/log'

CONFIG_LINKS_TO_REQUIRE =
    views: true
    styles: true
    models: true
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
        path = pathUtils.join ext.path, '/app.js'
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
    file += "Neft.eventLoop.lock()\n"
    file += "var opts = #{config};\n"
    file += 'opts.modules = typeof modules !== \'undefined\' ? modules : {};\n'

    if fs.existsSync(options.initFile)
        initFilePath = options.initFile
        unless pathUtils.isAbsolute(initFilePath)
            initFilePath = pathUtils.join '../', initFilePath
        file += "var init = require('#{initFilePath}');\n"
        file += 'module.exports = init(Neft.bind(null, opts));\n'
    else
        file += 'module.exports = Neft(opts);\n'
    file += "Neft.eventLoop.release();\n"

    file
