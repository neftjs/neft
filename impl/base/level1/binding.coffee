'use strict'

utils = require 'utils'
signal = require 'signal'

{assert} = console
{isArray} = Array

module.exports = (impl) ->
	{items} = impl

	class Connection
		constructor: (@binding, @item, @prop) ->
			{signalChangeListener} = @

			self = @
			@signalChangeListener = ->
				signalChangeListener.call self

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
			signalName = "#{@prop}Changed"
			handlerName = signal.getHandlerName signalName

			@item?[handlerName] @signalChangeListener

		updateChild: (child) ->
			signalName = "#{@prop}Changed"
			handlerName = signal.getHandlerName signalName

			if @item
				@item[handlerName].disconnect @signalChangeListener
				@item = null

			if child
				@item = child.getValue()
				@listen()
				@signalChangeListener()

		signalChangeListener: ->
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

		constructor: (@item, @obj, @uniqueProp, @prop, binding, @extraResultFunc) ->
			Binding.prepare binding, item

			# properties
			@__hash__ = utils.uid()
			@func = Binding.getFunc binding
			@args = Binding.getItems binding

			# bind methods
			{signalChangeListener} = @
			@signalChangeListener = (oldVal) =>
				signalChangeListener.call @, oldVal

			# destroy on property value change
			signalName = "#{prop}Changed"
			handlerName = signal.getHandlerName signalName
			obj[handlerName] @signalChangeListener

			# connections
			connections = @connections = []
			for elem in binding
				if isArray elem
					connections.push new Connection @, elem[0], elem[1]

			# update
			@update()

		item: null
		obj: null
		args: null
		uniqueProp: ''
		prop: ''
		func: null
		extraResultFunc: null
		updatePending: false
		connections: null

		signalChangeListener: (oldVal) ->
			if not @updatePending and oldVal isnt @obj[@prop]
				@destroy()

		update: do ->
			queue = []
			queueHashes = {}
			pending = false

			updateBinding = (binding) ->
				unless binding.args
					return

				result = binding.func.apply null, binding.args
				unless result?
					return

				# extra func
				if binding.extraResultFunc
					funcResult = binding.extraResultFunc binding.item
					if typeof funcResult is 'number' and isFinite(funcResult)
						result += funcResult

				if typeof result is 'number' and not isFinite(result)
					return

				binding.updatePending = true
				binding.obj[binding.prop] = result
				binding.updatePending = false

			updateAll = ->
				pending = false
				while queue.length
					binding = queue.pop()
					queueHashes[binding.__hash__] = false
					updateBinding binding
				null

			->
				if queueHashes[@__hash__]
					return

				queue.push @
				queueHashes[@__hash__] = true

				unless pending
					setImmediate updateAll
					pending = true

		destroy: ->
			# destroy connections
			for connection in @connections
				connection.destroy()

			# remove from the list
			@obj._impl.bindings[@uniqueProp] = null

			# disconnect listener
			signalName = "#{@prop}Changed"
			handlerName = signal.getHandlerName signalName
			@obj[handlerName].disconnect @signalChangeListener

			# clear props
			@args = null
			@connections = null

	setItemBinding: (obj, prop, binding, extraResultFunc) ->
		storage = obj._impl or @?._impl

		uniqueProp = "#{obj.constructor.__name__}-#{prop}"

		storage.bindings ?= {}
		storage.bindings[uniqueProp]?.destroy()

		if binding?
			storage.bindings[uniqueProp] = new Binding @, obj, uniqueProp, prop, binding, extraResultFunc