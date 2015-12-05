'use strict'

fs = require 'fs-extra'

{utils, log} = Neft

module.exports = (platform, options, callback) ->
	require("./saveBundle/#{platform}") options, callback