'use strict'

utils = require 'utils'

load = require './load.coffee'
clear = require './clear.coffee'
preparse = require './preparse.coffee'
parse = require './parse.coffee'
render = require './render.coffee'

# parsed views
cache = {}

exports = module.exports

exports.VIEWS_PATH = './'

exports.parse = (path, callback) ->

	if typeof path isnt 'string'
		throw new TypeError "View.parse() path is not a string"

	if typeof callback isnt 'function'
		throw new TypeError "View.parse() callback is not a function"

	if cache[path]? then return callback null, cache[path]

	basepath = exports.VIEWS_PATH + path
	pathbase = path.substring 0, path.lastIndexOf('/') + 1

	result =
		path: path
		basepath: basepath
		pathbase: pathbase
		doc: null # HTMLDocument
		file: null # DocumentFragment
		declarations: null
		placedunits: null
		contents: null
		changes: null

	stack = new utils.async.Stack

	stack.add null, load, basepath, result
	stack.add null, clear, result
	stack.add null, preparse, result
	stack.add null, parse, result
	
	stack.runAll (err) ->

		if err then return callback err
		cache[path] = result

		callback null, result

exports.render = (path, callback) ->

	if typeof path isnt 'string'
		throw new TypeError "View.render() path is not a string"

	if typeof callback isnt 'function'
		throw new TypeError "View.render() callback is not a function"

	if cache[path]? then return render cache[path], callback

	exports.parse path, (err, view) ->

		if err then return callback err
		render view, callback