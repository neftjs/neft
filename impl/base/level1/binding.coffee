'use strict'

utils = require 'utils'

{assert} = console

module.exports = (impl) ->
	{items} = impl

	class Binding
		@BINDING_RE = ///\i([0-9]+)\.(x|y|width|height)///g

		@update: (listeners) ->
			if listeners
				for binding in listeners
					binding.update()
			null

		cache = {}
		tmpFuncArgs = ['']

		constructor: (@itemId, @prop, @binding, @extraResultFunc) ->
			@locations = []
			func = @func = cache[binding.setup]
			args = @args = utils.clone binding.items

			unless func
				tmpFuncArgs.pop()
				tmpFuncArgs.pop()

				lenArr = tmpFuncArgs.length
				lenArgs = binding.items.length

				if lenArr > lenArgs
					tmpFuncArgs.length = lenArgs
				else if lenArr < lenArgs
					for i in [lenArr...lenArgs] by 1
						tmpFuncArgs[i] = "i#{i}"

				# prepare setup
				setup = binding.setup.replace Binding.BINDING_RE, (_, id, prop) ->
					"impl.#{impl.utils.GETTER_METHODS_NAMES[prop]}(i#{id})"

				tmpFuncArgs.push 'impl'
				tmpFuncArgs.push "return #{setup}"
				func = @func = Function.apply null, tmpFuncArgs
				cache[binding.setup] = func

			setImmediate =>
				# break on destroyed
				return unless @locations

				@ready = true

				# `this` arg
				thisIndex = args.indexOf 'this'
				if thisIndex isnt -1
					args[thisIndex] = itemId

				# `parent` arg
				parentIndex = args.indexOf 'parent'
				if parentIndex isnt -1
					@parentArgIndex = parentIndex
					@parentId = impl.getItemParent itemId
					args[parentIndex] = @parentId

				# register binding
				while bindingChunks = Binding.BINDING_RE.exec binding.setup
					[_, idIndex, prop] = bindingChunks
					id = args[idIndex]

					if item = items[id]
						item.listeners ?= {}
						itemListeners = item.listeners[prop] ?= []
						itemListeners.push @
						@locations.push itemListeners

				# add impl arg
				args.push impl

				# call automatically
				@update()

		ready: false
		itemId: ''
		parentArgIndex: -1
		parentId: ''
		prop: ''
		binding: null
		extraResultFunc: null
		func: null
		args: null
		locations: null
		updatePending: false

		updateParent: ->
			return unless @ready
			return if @parentArgIndex is -1

			# remove old one
			if @parentId
				for _, itemListeners of items[@parentId].listeners
					utils.remove itemListeners, @
					utils.remove @locations, itemListeners

			# join new one
			@parentId = impl.getItemParent @itemId
			@args[@parentArgIndex] = @parentId
			itemListeners = items[@parentId].listeners ?= {}
			itemListeners = itemListeners[@prop] ?= []
			itemListeners.push @
			@locations.push itemListeners

		update: ->
			return unless @ready

			result = @func.apply(null, @args)

			if @extraResultFunc
				funcResult = @extraResultFunc @itemId
				if typeof funcResult is 'number'
					result += funcResult

			@updatePending = true
			impl[impl.utils.SETTER_METHODS_NAMES[@prop]] @itemId, result
			@updatePending = false

		destroy: ->
			return if @updatePending

			for location in @locations
				utils.remove location, @

			items[@itemId].bindings[@prop] = null

			@locations = null
			@args = null

	impl.Types.Item.create = do (_super = impl.Types.Item.create) -> (id, target) ->
		target.bindings = null
		target.listeners = null

		_super id, target

	impl.setItemParent = do (_super = impl.setItemParent) -> (id, val) ->
		item = items[id]

		_super id, val

		if bindings = item.bindings
			for _, binding of bindings
				if binding?
					binding.updateParent()
					binding.update()
		null

	overrideSetter = (name) ->

		methodName = "setItem#{utils.capitalize name}"

		impl[methodName] = do (_super = impl[methodName]) -> (id, val) ->
			item = items[id]

			# remove binding
			item.bindings?[name]?.destroy()

			# call super
			_super id, val

			# update listeners
			Binding.update item.listeners?[name]

	overrideSetter 'x'
	overrideSetter 'y'
	overrideSetter 'width'
	overrideSetter 'height'

	setItemBinding: (id, prop, binding, extraResultFunc) ->
		item = items[id]
		item.bindings ?= {}

		item.bindings[prop]?.destroy()

		if binding?
			item.bindings[prop] = new Binding id, prop, binding, extraResultFunc