'use strict'

expect = require 'expect'
utils = require 'utils'
signal = require 'signal'

{isArray} = Array

module.exports = (Renderer, Impl) -> exports =
	defineProperty: (prototype, propName, implMethod, customGetter, customSetter) ->
		expect(prototype).toBe.object()
		expect(propName).toBe.truthy().string()
		expect().defined(customGetter).toBe.function()
		expect().defined(customSetter).toBe.function()

		signalName = "#{propName}Changed"
		signal.createLazy prototype, signalName

		propGetter = ->
			@_data[propName]

		propSetter = (val) ->
			oldVal = @_data[propName]
			if oldVal isnt val
				@_data[propName] = val
				@[signalName]? oldVal

			# TODO: why calling on only changes doesn't work?
			if @_data[propName] is val
				if implMethod
					implMethod.call(@_item or @, val)
				return true
			else
				return false

		# custom desc
		getter = if customGetter? then customGetter(propGetter) else propGetter
		setter = if customSetter? then customSetter(propSetter) else propSetter

		# accept bindings
		if prototype.constructor.__path__?.indexOf('Renderer.') isnt 0
			setter = exports.createDeepBindingSetter propName, setter
		else
			setter = exports.createBindingSetter propName, setter

		# override
		utils.defineProperty prototype, propName, utils.ENUMERABLE, getter, setter

		prototype

	createBindingSetter: (propName, setFunc) ->
		(val) ->
			if val and isArray val.binding
				Impl.setItemBinding.call @, @, propName, val.binding
			else
				setFunc.call @, val

	createDeepBindingSetter: (propName, setFunc) ->
		(val) ->
			if val and isArray val.binding
				Impl.setItemBinding.call @_item, @, propName, val.binding
			else
				setFunc.call @, val

	setProperty: (item, key, val) ->
		if typeof val is 'function'
			return item[key].connect val

		if val? and typeof val is 'object' and key of item.constructor.prototype and not Array.isArray(val.binding) and not(val instanceof Renderer.Item) 
			return utils.merge item[key], val

		item[key] = val

	fill: (item, opts) ->
		if opts?
			# set properties
			for key, val of opts
				unless key of item
					throw "Unexpected property `#{key}`"

				if typeof val is 'function'
					continue

				exports.setProperty item, key, val

			# connect handlers
			for key, val of opts
				unless key of item
					throw "Unexpected property `#{key}`"

				if typeof val is 'function'
					item[key].connect val