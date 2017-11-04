'use strict'

log = require 'src/log'

module.exports = (platform, options, callback) ->
    log.show ''
    require("./saveBundle/#{platform}") options, callback
