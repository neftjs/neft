'use strict'

utils = require 'utils'

module.exports = do ->
	if utils.isBrowser
		impl = require './implementations/browser'
	impl ||= require './implementations/memory'
	impl
