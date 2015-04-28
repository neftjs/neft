'use strict'

utils = require 'utils'
signal = require 'signal'

module.exports = (Renderer, Impl, itemUtils) -> class Extension extends itemUtils.Object
	@__name__ = 'Extension'

	constructor: ->
		@_impl ?= bindings: null
		@_target = null
		@_running = false
		@_when = false
		@_whenHandler = null
		super()

	signalListener = ->
		unless @_when
			@_when = true
			@whenChanged false
			unless @_running
				@enable()
		return

	itemUtils.defineProperty
		constructor: @
		name: 'when'
		defaultValue: false
		setter: (_super) -> (val) ->
			if @_whenHandler
				@_whenHandler.disconnect signalListener, @
				@_whenHandler = null

			if typeof val is 'function' and val.connect?
				val.connect signalListener, @
				@_whenHandler = val
			else
				_super.call @, !!val

				if val and not @_running
					@enable()
				else if not val and @_running
					@disable()
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
