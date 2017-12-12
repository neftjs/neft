'use strict'

pathUtils = require 'path'
fs = require 'fs'
Mustache = require 'mustache'

module.exports = (config, callback) ->
    appTmplPath = pathUtils.resolve __dirname, './browser/app.js.mustache'
    appTmpl = fs.readFileSync appTmplPath, 'utf-8'

    # write neft file
    fs.writeFileSync "./build/#{config.neftFileName}", config.neftCode

    # write app file
    appCode = Mustache.render appTmpl, config
    fs.writeFile "./build/#{config.appFileName}", appCode, 'utf-8', callback
