'use strict'

utils = require 'utils'
signal = require 'signal'
log = require 'log'
assert = require 'assert'

log = log.scope 'Renderer', 'Binding'

{isArray} = Array

getPropHandlerName = do ->
	cache = Object.create null
	(prop) ->
		cache[prop] ?= "on#{utils.capitalize(prop)}Change"

module.exports = (impl) ->
	{items} = impl

	class Connection
		constructor: (@binding, @item, @prop, @parent=null) ->
			@handlerName = getPropHandlerName prop
			@isConnected = false

			if isArray(item)
				@child = new Connection binding, item[0], item[1], @
				@item = @child.getValue()
			else
				if @item is 'this'
					@item = @binding.ctx
				@child = null
			@connect()

			Object.preventExtensions @

		getSignalChangeListener = do ->
			withParent = ->
				@parent.updateItem()
			noParent = ->
				@binding.update()

			(connection) ->
				if connection.parent
					withParent
				else
					noParent

		update: ->
			getSignalChangeListener(@).call @

		connect: ->
			if @item
				handler = @item[@handlerName]
				if handler?
					@isConnected = true
					handler getSignalChangeListener(@), @
			return

		disconnect: ->
			if @item and @isConnected
				@item[@handlerName].disconnect getSignalChangeListener(@), @
			@isConnected = false
			return

		updateItem: ->
			oldVal = @item
			val = @child.getValue()
			if oldVal isnt val or utils.isObject(val)
				@disconnect()
				@item = val
				@connect()

				if @parent
					@parent.updateItem()
				else
					@binding.update()
			return

		getValue: ->
			@item?[@prop]

		destroy: ->
			@disconnect()
			@child?.destroy()
			return

	isSimpleBinding = (binding) ->
		binding[1].length is 1 and isArray(binding[1][0]) and not isArray(binding[1][0][0])

	class SimpleBinding
		constructor: (@obj, @prop, binding, ctx) ->
			item = obj._ref or obj
			target = @target = binding[1][0]

			if target[0] is 'this'
				@targetItem = ctx
			else
				@targetItem = target[0]

			handlerName = "on#{utils.capitalize(target[1])}Change"
			@targetItem[handlerName]? @update, @

			Object.preventExtensions @

			@update()

		update: ->
			@obj[@prop] = @targetItem[@target[1]]
			return

		destroy: ->
			handlerName = "on#{utils.capitalize(@target[1])}Change"
			@targetItem[handlerName].disconnect @update, @
			# remove from the list
			@obj._impl.bindings[@prop] = null
			return

	class Binding
		@getFunc = do ->
			cache = Object.create null
			(binding) ->
				if fromCache = cache[binding[0]]
					fromCache
				else
					args = []
					for i in [0...binding[2].length] by 1
						args[i] = "$#{i}"

					args.push "return #{binding[0] or 0};"
					cache[binding[0]] = Function.apply null, args

		constructor: (@obj, @prop, binding, @ctx) ->
			assert.lengthOf binding, 3
			assert.isString binding[0]
			assert.isArray binding[1]
			assert.isArray binding[2]

			item = @item = obj._ref or obj

			# properties
			@func = Binding.getFunc binding
			@args = binding[2]

			# destroy on property value change
			handlerName = "on#{utils.capitalize(prop)}Change"

			# connections
			connections = @connections = []
			for elem in binding[1]
				if isArray(elem)
					connections.push new Connection @, elem[0], elem[1]

			# update
			@updatePending = false
			Object.preventExtensions @

			@update()

		getDefaultValue = (binding) ->
			val = binding.obj[binding.prop]
			switch typeof val
				when 'string'
					''
				when 'number'
					0
				when 'boolean'
					false
				else
					null

		update: ->
			unless @args
				return

			result = utils.tryFunction @func, @ctx, @args
			unless result?
				result = getDefaultValue @

			if typeof result is 'number' and not isFinite(result)
				result = getDefaultValue @

			@updatePending = true
			@obj[@prop] = result
			@updatePending = false
			return

		destroy: ->
			# destroy connections
			for connection in @connections
				connection.destroy()

			# remove from the list
			@obj._impl.bindings[@prop] = null

			# clear props
			@args = null
			@connections = null
			return

	setItemBinding: (prop, binding, ctx) ->
		data = @_impl
		data.bindings ?= {}

		if data.bindings[prop]?.updatePending
			return

		data.bindings[prop]?.destroy()

		if binding?
			if isSimpleBinding(binding)
				data.bindings[prop] = new SimpleBinding @, prop, binding, ctx
			else
				data.bindings[prop] = new Binding @, prop, binding, ctx

		return
