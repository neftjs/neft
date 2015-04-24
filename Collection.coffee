'use strict'

module.exports = class Collection
	constructor: (@self) ->

	run: (callback) ->
		callback new Error

	removeAll: (callback) ->
		callback new Error

	updateAll: (doc, callback) ->
		callback new Error
