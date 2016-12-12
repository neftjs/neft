'use strict'

fs = require 'fs-extra'
utils = require 'src/utils'
log = require 'src/log'

module.exports = (platform, options, callback) ->
    require("./saveBundle/#{platform}") options, callback
