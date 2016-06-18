'use strict'

fs = require 'fs'
cliUtils = require '../../../utils.coffee'
glob = require 'glob'

{utils, log} = Neft

CONFIG_LINKS_TO_REQUIRE =
    views: true
    styles: true
    models: true
    routes: true

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

    # include document extensions
    packageFile = JSON.parse fs.readFileSync('./package.json', 'utf-8')
    try
        for key of packageFile.dependencies
            if /^neft\-document\-/.test(key)
                app.extensions.push "`require('#{key}')`"

    # get 'package.json' config
    app.config = packageFile.config

    # parse app into object
    config = JSON.stringify app, jsonReplacer
    config = config.replace ///"`///g, ''
    config = config.replace ///`"///g, ''

    # create file
    file = ''
    file += "var opts = #{config};\n"
    file += 'var init = require(\'./init\');\n'
    file += 'opts.modules = typeof modules !== \'undefined\' ? modules : {};\n'
    file += 'module.exports = init(Neft.bind(null, opts));\n'

    # run tests
    if options.withTests
        testFiles = glob.sync './tests/**/*.js'

        file += 'window.app = module.exports;\n'
        file += 'Neft.unit = require(\'lib/unit\');\n'
        file += 'Neft.unit.runAutomatically = false;\n'
        file += 'app.onReady(function() {\n'
        for testFile in testFiles
            file += "    require('#{testFile}');\n"
            file += '    Neft.unit.runTests();\n'
        file += '});\n'

    file
