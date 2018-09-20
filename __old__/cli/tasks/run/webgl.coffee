'use strict'

fs = require 'fs'
open = require 'open'
cliUtils = require 'cli/utils'
log = require 'src/log'

WAIT_TIME = 1000 * 10 # 10s

module.exports = (options) ->
    packageFile = JSON.parse fs.readFileSync './package.json'
    {config} = packageFile
    url = config.url
    url ?= "#{config.protocol}://#{config.host}:#{config.port}/"
    url += "neft-type=game/"

    timeoutReached = ->
        log.error "Cannot find run server; did you execute `neft run node`?"

    timer = setTimeout timeoutReached, WAIT_TIME

    cliUtils.onUrlAccessible config.protocol, url, ->
        clearTimeout timer
        open url

    return
