'use strict'

expect = require 'expect'

View = require 'view'

expect(View).toBe.function()

module.exports = (data) ->
	require('./file/funcs') View
	require('./file/styles') View
	require('./file/render') View

	View.Style = require('./style') View, data
