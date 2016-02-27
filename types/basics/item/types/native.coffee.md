Native @class
=============

	'use strict'

	utils = require 'neft-utils'
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
				ctorName = utils.capitalize @constructor.__name__
				id = @_impl.id
				name = utils.capitalize name
				funcName = "rendererSet#{ctorName}#{name}"
				nativeBridge.callFunction funcName, id, val
				return

Native::call(*String* funcName, *Any* args...)
----------------------------------------------

			call: (name, args...) ->
				ctorName = utils.capitalize @constructor.__name__
				id = @_impl.id
				name = utils.capitalize name
				funcName = "rendererCall#{ctorName}#{name}"

				callArgs = [funcName, id, args...]
				nativeBridge.callFunction.apply nativeBridge, callArgs
				return

Native::on(*String* eventName, *Function* listener)
---------------------------------------------------

			on: (name, func) ->
				ctorName = utils.capitalize @constructor.__name__
				id = @_impl.id
				name = utils.capitalize name
				eventName = "rendererOn#{ctorName}#{id}#{name}"
				nativeBridge.on eventName, func
				return

		Native
