'use strict'

expect = require 'expect'
utils = require 'utils'
Dict = require 'dict'

{isArray} = Array

module.exports = (Renderer, Impl) -> exports =
	defineProperty: (prototype, propName, customGetter, customSetter) ->
		expect(prototype).toBe.object();
		expect(propName).toBe.truthy().string();
		expect().defined(customGetter).toBe.function();
		expect().defined(customSetter).toBe.function();

		Dict.defineProperty prototype, propName

		# dist desc
		propGetter = utils.lookupGetter prototype, propName
		propSetter = utils.lookupSetter prototype, propName

		# custom desc
		getter = if customGetter? then customGetter(propGetter) else propGetter
		setter = if customSetter? then customSetter(propSetter) else propSetter

		# accept bindings
		if prototype.constructor.__path__.indexOf('Renderer.') isnt 0
			setter = exports.createDeepBindingSetter propName, setter
		else
			setter = exports.createBindingSetter propName, setter

		# override
		utils.defProp prototype, propName, 'e', getter, setter

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

		if val? and typeof val is 'object' and key of item.constructor.prototype and not Array.isArray(val) and not(val instanceof Renderer.Item) 
			return utils.merge item[key], val

		item[key] = val