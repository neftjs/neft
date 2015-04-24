'use strict'

module.exports = class Table
	constructor: (@self, @name) ->

	run: (callback) ->
		callback new Error

	insertData: (doc, callback) ->
		callback new Error
