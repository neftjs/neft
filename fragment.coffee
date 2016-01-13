'use script'

utils = require 'utils'
assert = require 'neft-assert'
signal = require 'signal'

assert = assert.scope 'View.Fragment'

module.exports = (File) -> class Fragment extends File
	@__name__ = 'Fragment'
	@__path__ = 'File.Fragment'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Fragment) - 1

	i = File.JSON_ARGS_LENGTH
	JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

	constructor: (path, node) ->
		super path, node

		`//<development>`
		if @constructor is Fragment
			Object.preventExtensions @
		`//</development>`
	
	utils.defineProperty @::, 'name', null, ->
		@node.getAttr 'neft:name'
	, null
	
	toJSON: (key, arr) ->
		unless arr
			arr = new Array JSON_ARGS_LENGTH
			arr[0] = JSON_CTOR_ID
		super key, arr
