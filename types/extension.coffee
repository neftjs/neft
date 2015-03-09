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
		@_isWhenListens = false
		@onWhenChanged onWhenChanged

	signalListener = ->
		@when = true

	itemUtils.defineProperty
		constructor: @
		name: 'when'
		defaultValue: false
		setter: (_super) -> (val) ->
			if typeof val is 'function' and val.connect?
				unless @_isWhenListens
					val.connect signalListener, @
					@_isWhenListens = true
			else
				_super.call @, !!val
			return

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
