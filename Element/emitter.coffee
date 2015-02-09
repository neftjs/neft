'use strict'

assert = require 'assert'
utils = require 'utils'

module.exports = class Emitter

	_i = 0
	@PARENT_CHANGED = _i++
	@VISIBILITY_CHANGED = _i++
	@ATTR_CHANGED = @TEXT_CHANGED = _i++

	@trigger = (emitter, type, param) ->
		assert.instanceOf emitter, Emitter
		assert.isInteger type

		listeners = emitter._events?[type]
		if listeners
			i = 0
			n = listeners.length

			while i < n
				if listeners[i]
					listeners[i].call listeners[i+1], param, emitter
					i += 2
				else
					listeners.splice i, 2
					n -= 2

		return

	constructor: ->
		@_events = null

	createHandler = (id) ->
		currentEmitter = null

		func = (func, ctx=@) ->
			assert.isFunction func

			@_events ?= [null, null, null]
			@_events[id] ?= []
			@_events[id].push func, ctx
			return

		func.connect = func
		func.disconnect = (func, ctx=currentEmitter) ->
			events = currentEmitter._events[id]
			index = 0

			loop
				index = events.indexOf func, index
				if index is -1 or events[index+1] is ctx
					break
				index += 2
			assert.isNot index, -1

			events[index] = null
			events[index+1] = null

			return

		getter = ->
			currentEmitter = @
			func

	utils.defineProperty @::, 'onParentChanged', null, createHandler(@PARENT_CHANGED), null
	utils.defineProperty @::, 'onVisibilityChanged', null, createHandler(@VISIBILITY_CHANGED), null
	utils.defineProperty @::, 'onAttrChanged', null, createHandler(@ATTR_CHANGED), null
	utils.defineProperty @::, 'onTextChanged', null, createHandler(@TEXT_CHANGED), null
