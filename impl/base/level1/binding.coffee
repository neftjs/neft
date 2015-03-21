'use strict'

utils = require 'utils'
signal = require 'signal'
log = require 'log'

log = log.scope 'Renderer', 'Binding'

{assert} = console
{isArray} = Array

getPropHandlerName = do ->
	cache = Object.create null
	(prop) ->
		cache[prop] ?= signal.getHandlerName "#{prop}Changed"

module.exports = (impl) ->
	{items} = impl

	class Connection
		constructor: (@binding, @item, @prop, @parent=null) ->
			@handlerName = getPropHandlerName prop
			@isConnected = false

			if isArray item
				@child = new Connection null, item[0], item[1], @
				@item = @child.getValue()
			else
				@child = null
			@connect()

			if @item instanceof impl.Renderer.Item and not @item._isReady
				@item.onReady @update, @

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

	class Binding
		@prepare = (arr, item) ->
			for elem, i in arr
				if isArray elem
					Binding.prepare elem, item
				else if elem is 'this'
					arr[i] = item
			null

		@getHash = do ->
			argI = 0

			(arr, isFork=false) ->
				r = ''
				for elem, i in arr
					if isArray elem
						r += Binding.getHash elem, true
					else if typeof elem is 'string'
						if i is 1 and typeof arr[0] is 'object' and ///^[a-zA-Z_$]///.test elem
							r += "."
						r += elem
					else if typeof elem is 'object'
						r += "$#{argI++}"
				unless isFork
					argI = 0
				r

		@getItems = (arr, r=[])->
			for elem in arr
				if isArray elem
					Binding.getItems elem, r
				else if typeof elem is 'object'
					r.push elem
			r				

		@getFunc = do (cache = {}) -> (binding) ->
			hash = Binding.getHash binding
			if cache.hasOwnProperty hash
				cache[hash]
			else
				args = Binding.getItems binding
				for _, i in args
					args[i] = "$#{i}"

				hash ||= '0'
				args.push "return #{hash};"
				cache[hash] = Function.apply null, args

		# TODO: implement fast bindings [[item, prop]]
		constructor: (@obj, @prop, binding, @extraResultFunc=null) ->
			item = obj._ref or obj
			Binding.prepare binding, item

			# properties
			@func = Binding.getFunc binding
			@args = Binding.getItems binding

			# destroy on property value change
			signalName = "#{prop}Changed"
			handlerName = signal.getHandlerName signalName

			# connections
			connections = @connections = []
			for elem in binding
				if isArray elem
					connections.push new Connection @, elem[0], elem[1]

			# update
			@updatePending = false
			@defaultValue = @obj[prop]
			Object.preventExtensions @

			if item._isReady
				@update()
			else
				item.onReady @update, @

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

			result = utils.tryFunction @func, null, @args
			unless result?
				result = getDefaultValue @

			# extra func
			if @extraResultFunc
				funcResult = @extraResultFunc @obj
				if typeof funcResult is 'number' and isFinite(funcResult)
					result += funcResult

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

			# restore default value
			# @getObj()[@prop] = @defaultValue
			return

	setItemBinding: (prop, binding, extraResultFunc) ->
		data = @_impl
		data.bindings ?= {}

		if data.bindings[prop]?.updatePending
			return

		data.bindings[prop]?.destroy()

		if binding?
			data.bindings[prop] = new Binding @, prop, binding, extraResultFunc
		return
