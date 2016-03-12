Native @class
=============

	'use strict'

	utils = require 'neft-utils'
	log = require 'neft-log'
	assert = require 'neft-assert'
	nativeBridge = require 'neft-native'

	module.exports = (Renderer, Impl, itemUtils) ->

		class Native extends Renderer.Item
			@__name__ = 'Native'
			@__path__ = 'Renderer.Native'

			@New = (component, opts) ->
				item = new this
				itemUtils.Object.initialize item, component, opts
				@Initialize? item
				item

			@defineProperty = (opts) ->
				unless opts.hasOwnProperty('constructor')
					opts.constructor = this
				opts.implementation ?= do ->
					ctorName = utils.capitalize opts.constructor.__name__
					name = utils.capitalize opts.name
					funcName = "rendererSet#{ctorName}#{name}"
					(val) ->
						nativeBridge.callFunction funcName, @_impl.id, val
				itemUtils.defineProperty opts

*Native* Native() : *Renderer.Item*
-----------------------------------

			constructor: ->
				super()

Native::set(*String* propName, *Any* val)
-----------------------------------------

			set: (name, val) ->
				assert.isString name

				ctorName = utils.capitalize @constructor.__name__
				id = @_impl.id
				name = utils.capitalize name
				funcName = "rendererSet#{ctorName}#{name}"
				nativeBridge.callFunction funcName, id, val
				return

Native::call(*String* funcName, *Any* args...)
----------------------------------------------

			call: (name, args...) ->
				assert.isString name

				ctorName = utils.capitalize @constructor.__name__
				id = @_impl.id
				name = utils.capitalize name
				funcName = "rendererCall#{ctorName}#{name}"

				callArgs = [funcName, id, args...]
				nativeBridge.callFunction.apply nativeBridge, callArgs
				return

Native::on(*String* eventName, *Function* listener)
---------------------------------------------------

			# nativeEventName -> item id -> [item, listeners...]
			eventListeners = Object.create null

			createNativeEventListener = (listeners, eventName) -> (id) ->
				unless itemListeners = listeners[id]
					log.warn "Got a native event '#{eventName}' for an item which " +
						"didn't register a listener on this event; check if you " +
						"properly call 'on()' method with a signal listener"
					return

				length = arguments.length
				args = new Array length - 1
				for i in [0...length-1] by 1
					args[i] = arguments[i + 1]

				item = itemListeners[0]
				for i in [1...itemListeners.length] by 1
					itemListeners[i].apply item, args

				return

			on: (name, func) ->
				assert.isString name
				assert.isFunction func

				ctorName = utils.capitalize @constructor.__name__
				name = utils.capitalize name
				eventName = "rendererOn#{ctorName}#{name}"

				unless listeners = eventListeners[eventName]
					listeners = eventListeners[eventName] = Object.create(null)
					nativeBridge.on eventName, createNativeEventListener(listeners, eventName)

				itemListeners = listeners[@_impl.id] ?= [@]
				itemListeners.push func
				return

		Native
