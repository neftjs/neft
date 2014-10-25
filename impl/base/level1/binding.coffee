'use strict'

utils = require 'utils'
signal = require 'signal'
Dict = require 'dict'

{assert} = console
{isArray} = Array

module.exports = (impl) ->
	{items} = impl

	class Connection
		constructor: (@binding, @item, @prop) ->
			{changeListener} = @

			@changeListener = =>
				if @debug
					debugger
				changeListener.call @

			if isArray item
				@item = null
				child = new Connection binding, item[0], item[1]
				child.parent = @
				@updateChild child
			else
				@listen()

		binding: null
		item: null
		prop: null
		parent: null

		listen: ->
			signalName = Dict.getPropertySignalName @prop
			handlerName = signal.getHandlerName signalName

			@item?[handlerName] @changeListener

		updateChild: (child) ->
			signalName = Dict.getPropertySignalName @prop
			handlerName = signal.getHandlerName signalName

			if @item
				@item[handlerName].disconnect @changeListener
				@item = null

			if child
				@item = child.getValue()
				@listen()
				@changeListener()

		changeListener: ->
			if @parent
				@parent.updateChild @
			else
				@binding.update()

		getValue: ->
			@item[@prop]

		destroy: ->
			@updateChild null

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
						if i is 1 and typeof arr[0] is 'object' and ///^[a-zA-Z_]///.test elem
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
				args.push "try { return #{hash}; } catch(err){}"
				cache[hash] = Function.apply null, args

		# TODO: remove it
		@clone = (binding) ->
			binding = utils.clone binding
			for elem, i in binding
				if isArray elem
					binding[i] = Binding.clone elem
			binding

		constructor: (@item, @prop, binding, @extraResultFunc) ->
			binding = Binding.clone binding
			Binding.prepare binding, item

			# properties
			@func = Binding.getFunc binding
			@args = Binding.getItems binding

			# bind methods
			{changeListener} = @
			@changeListener = => changeListener.call @

			# destroy on property value change
			signalName = Dict.getPropertySignalName prop
			handlerName = signal.getHandlerName signalName
			item[handlerName] @changeListener

			# connections
			connections = @connections = []
			for elem in binding
				if isArray elem
					connections.push new Connection @, elem[0], elem[1]

			# update
			@update()

		item: null
		args: null
		prop: ''
		func: null
		extraResultFunc: null
		updatePending: false
		connections: null

		changeListener: ->
			unless @updatePending
				@destroy()

		update: ->
			result = @func.apply null, @args
			unless result?
				return

			# extra func
			if @extraResultFunc
				funcResult = @extraResultFunc @item
				if typeof funcResult is 'number' and isFinite(funcResult)
					result += funcResult

			@updatePending = true
			@item[@prop] = result
			@updatePending = false

		destroy: ->
			# destroy connections
			for connection in @connections
				connection.destroy()

			# remove from the list
			@item._impl.bindings[@prop] = null

			# disconnect listener
			signalName = Dict.getPropertySignalName @prop
			handlerName = signal.getHandlerName signalName
			@item[handlerName].disconnect @changeListener

			# clear props
			@args = null
			@connections = null

	setItemBinding: (prop, binding, extraResultFunc) ->
		storage = @_impl

		storage.bindings ?= {}
		storage.bindings[prop]?.destroy()

		if binding?
			storage.bindings[prop] = new Binding @, prop, binding, extraResultFunc