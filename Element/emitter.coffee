'use strict'

assert = require 'assert'
utils = require 'utils'

module.exports = class Emitter

	i = 0
	@PARENT_CHANGED = i++
	@VISIBILITY_CHANGED = i++
	@ATTR_CHANGED = @TEXT_CHANGED = i++

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

		func = (func, ctx) ->
			assert.isFunction func

			@_events ?= [null, null, null]
			@_events[id] ?= []
			@_events[id].push func, (ctx or @)
			return

		func.connect = func
		func.disconnect = (func) ->
			index = currentEmitter._events[id].indexOf func
			assert.isNot index, -1

			currentEmitter._events[id][index] = null
			currentEmitter._events[id][index+1] = null
			return

		getter = ->
			currentEmitter = @
			func

	utils.defineProperty @::, 'onParentChanged', null, createHandler(@PARENT_CHANGED), null
	utils.defineProperty @::, 'onVisibilityChanged', null, createHandler(@VISIBILITY_CHANGED), null
	utils.defineProperty @::, 'onAttrChanged', null, createHandler(@ATTR_CHANGED), null
	utils.defineProperty @::, 'onTextChanged', null, createHandler(@TEXT_CHANGED), null
