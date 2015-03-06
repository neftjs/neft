'use strict'

utils = require 'utils'
signal = require 'signal'

module.exports = (Renderer, Impl, itemUtils) -> class Extension extends itemUtils.Object
	@__name__ = 'Extension'

	onWhenChanged = ->
		isTrue = @when
		{running} = @

		if isTrue and not running
			@enable()
		else if not isTrue and running
			@disable()

	constructor: ->
		super()
		@_impl ?= bindings: null
		@_target = null
		@_running = false
		@onWhenChanged onWhenChanged

	itemUtils.defineProperty
		constructor: @
		name: 'when'
		defaultValue: false
		setter: (_super) -> (val) ->
			_super.call @, !!val

	itemUtils.defineProperty
		constructor: @
		name: 'target'
		defaultValue: null

	utils.defineProperty @::, 'running', utils.CONFIGURABLE, ->
		@_running
	, null

	enable: ->
		@_running = true

	disable: ->
		@_running = false
