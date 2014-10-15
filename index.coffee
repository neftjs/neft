'use strict'

expect = require 'expect'

View = require 'view'

expect(View).toBe.function()

module.exports = (scopes) ->
	require('./file/funcs') View, scopes
	require('./file/styles') View, scopes
	require('./file/render') View, scopes
