'use strict'

fs = require 'fs'
open = require 'open'

module.exports = (options) ->
    packageFile = JSON.parse fs.readFileSync './package.json'
    {config} = packageFile
    url = config.url
    url ?= "#{config.protocol}://#{config.host}:#{config.port}"
    open url
