'use strict'

fs = require 'fs'
open = require 'open'
cp = require 'child_process'

{log} = Neft

module.exports = (platform, options) ->
    platformRun = require "./run/#{platform}"
    log.show ''
    platformRun options
