'use strict'

log = require 'src/log'

module.exports = (platform, options, callback) ->
    require("./saveBundle/#{platform}") options, callback
