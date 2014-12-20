'use strict'

expect = require 'expect'
View = require 'view'

stylesFuncs = require('./file/funcs')
stylesStyles = require('./file/styles')
stylesRender = require('./file/render')
stylesStyle = require('./style')

expect(View).toBe.function()

module.exports = (data) ->
	stylesFuncs View
	stylesStyles View
	stylesRender View

	View.Style = stylesStyle View, data
