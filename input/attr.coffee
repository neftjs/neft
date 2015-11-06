'use strict'

assert = require 'neft-assert'
utils = require 'utils'

module.exports = (File, Input) -> class InputAttr extends Input
	@__name__ = 'InputAttr'
	@__path__ = 'File.Input.Attr'

	constructor: (node, func) ->
		@attrName = ''
		@handlerFunc = null
		@lastValue = NaN
		super node, func

	isHandler = (name) ->
		/^on[A-Z]|\:on[A-Z][A-Za-z0-9_$]*$/.test(name)

	update: ->
		super()
		str = @handlerFunc or @toString()
		if str isnt @lastValue
			@lastValue = str
			@node.attrs.set @attrName, str
		return

	createHandlerFunc = (input) ->
		(arg1, arg2) ->
			r = input.toString()
			if typeof r is 'function'
				r.call @, arg1, arg2
			return

	clone: (original, self) ->
		clone = super original, self
		clone.attrName = @attrName
		if isHandler(@attrName)
			clone.traceChanges = false
			clone.handlerFunc = createHandlerFunc clone
		clone