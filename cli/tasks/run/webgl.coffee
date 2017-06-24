'use strict'

fs = require 'fs'
open = require 'open'
cliUtils = require 'cli/utils'

module.exports = (options) ->
    packageFile = JSON.parse fs.readFileSync './package.json'
    {config} = packageFile
    url = config.url
    url ?= "#{config.protocol}://#{config.host}:#{config.port}/"
    url += "neft-type=game/"

    cliUtils.onUrlAccessible config.protocol, url, ->
        open url

    return
