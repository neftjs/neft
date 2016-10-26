'use strict'

pathUtils = require 'path'
fs = require 'fs'
Mustache = require 'mustache'

module.exports = (config, callback) ->
    appTmplPath = pathUtils.resolve __dirname, './browser/app.js.mustache'
    appTmpl = fs.readFileSync appTmplPath, 'utf-8'

    # write neft file
    fs.writeFileSync "./build/#{config.neftFileName}", config.neftCode
    neftGamePath = "../../../../bundle/neft-browser-game-#{config.mode}.js"
    neftGame = fs.readFileSync pathUtils.resolve(__dirname, neftGamePath), 'utf-8'
    fs.writeFileSync "./build/neft-browser-game-#{config.mode}.js", neftGame

    # write app file
    appCode = Mustache.render appTmpl, config
    fs.writeFile "./build/#{config.appFileName}", appCode, 'utf-8', callback
