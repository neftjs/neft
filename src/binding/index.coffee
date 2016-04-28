'use strict'

utils = require 'src/utils'
log = require 'src/log'
assert = require 'src/assert'
Dict = require 'src/dict'
List = require 'src/list'

log = log.scope 'Binding'

{isArray} = Array

MAX_LOOPS = 50

getPropHandlerName = do ->
	cache = Object.create null
	(prop) ->
		cache[prop] ||= "on#{utils.capitalize(prop)}Change"

class Connection
	pool = []

	@factory = (binding, item, prop, parent=null) ->
		if pool.length > 0 and (elem = pool.pop())
			Connection.call elem, binding, item, prop, parent
			elem
		else
			new Connection binding, item, prop, parent

	constructor: (@binding, item, @prop, @parent) ->
		@handlerName = getPropHandlerName @prop
		@isConnected = false

		if isArray(item)
			@itemId = ''
			@child = Connection.factory @binding, item[0], item[1], @
			@item = @child.getValue()
		else
			@itemId = item
			@child = null
			@item = @binding.getItemById item
		@connect()

		Object.seal @

	getSignalChangeListener: do ->
		withParent = (prop, val) ->
			# TODO: provide special signal emitted with property changed
			if val is undefined or typeof prop isnt 'string' or @parent.prop is prop
				@parent.updateItem()
			return

		noParent = ->
			@binding.update()
			return

		withParentOnDict = (prop) ->
			if @prop is prop
				@parent.updateItem()
			return

		noParentOnDict = (prop) ->
			if @prop is prop
				@binding.update()
			return

		->
			if @item instanceof Dict
				if @parent
					withParentOnDict
				else
					noParentOnDict
			else
				if @parent
					withParent
				else
					noParent

	update: ->
		@getSignalChangeListener().call @

	connect: ->
		{item} = @
		if item
			if item instanceof Dict
				@isConnected = true
				item.onChange @getSignalChangeListener(), @
			else if item instanceof List
				@isConnected = true
				handler = @getSignalChangeListener()
				item.onChange handler, @
				item.onInsert handler, @
				item.onPop handler, @
			else if handler = item[@handlerName]
				@isConnected = true
				handler @getSignalChangeListener(), @
		return

	disconnect: ->
		{item} = @
		if item and @isConnected
			handler = @getSignalChangeListener()
			if item instanceof Dict
				item.onChange.disconnect handler, @
			else if item instanceof List
				item.onChange.disconnect handler, @
				item.onInsert.disconnect handler, @
				item.onPop.disconnect handler, @
			else
				item[@handlerName].disconnect handler, @
		@isConnected = false
		return

	updateItem: ->
		oldVal = @item
		if @child
			val = @child.getValue()
		else
			val = @binding.getItemById @itemId

		if oldVal and not @isConnected
			@connect()
			oldVal = null

		if oldVal isnt val
			@disconnect()
			@item = val
			@connect()
			unless @parent
				@binding.update()

		if @parent
			@parent.updateItem()
		return

	getValue: ->
		if @item
			@item[@prop]
		else
			null

	destroy: ->
		@disconnect()
		@child?.destroy()
		pool.push @
		return

module.exports =
class Binding
	@New = (binding, ctx, target) ->
		target ?= new Binding binding, ctx
		Object.seal target

		# connections
		{connections} = target
		for elem in binding[1]
			if isArray(elem)
				connections.push Connection.factory target, elem[0], elem[1]

		target

	constructor: (binding, @ctx) ->
		assert.lengthOf binding, 2
		assert.isFunction binding[0]
		assert.isArray binding[1]

		# properties
		@func = binding[0]
		@args = null
		@connections ||= []

		# update
		`//<development>`
		@updatePending = false
		@updateLoop = 0
		`//</development>`

	getItemById: (item) ->
		throw "Not implemented"

	getValue: ->
		throw "Not implemented"

	getDefaultValue: ->
		switch typeof @getValue()
			when 'string'
				''
			when 'number'
				0
			when 'boolean'
				false
			else
				null

	setValue: (val) ->
		throw "Not implemented"

	onError: (err) ->

	update: ->
		unless @args
			return

		`//<development>`
		if @updatePending
			if @updateLoop > MAX_LOOPS
				return
			if ++@updateLoop is MAX_LOOPS
				log.error @getLoopDetectedErrorMessage()
				return
		else
			@updateLoop = 0
		`//</development>`

		result = utils.tryFunction @func, @ctx, @args
		if result instanceof Error
			@onError result
			result = @getDefaultValue()

		`//<development>`
		@updatePending = true
		`//</development>`

		@setValue result

		`//<development>`
		@updatePending = false
		`//</development>`
		return

	getLoopDetectedErrorMessage: ->
		"Potential loop detected"

	destroy: ->
		# destroy connections
		while connection = @connections.pop()
			connection.destroy()

		# clear props
		@args = null
		return
