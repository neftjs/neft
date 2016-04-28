'use strict'

utils = require 'src/utils'

module.exports = do ->
	if utils.isBrowser
		impl = require './implementations/browser'
	impl ||= require './implementations/memory'
	impl
