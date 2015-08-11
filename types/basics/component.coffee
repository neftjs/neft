'use strict'

utils = require 'utils'
assert = require 'neft-assert'

module.exports = (Renderer, Impl, itemUtils) -> class Component
	constructor: (original=null) ->
		if original?
			assert.instanceOf original, Component

		@item = null
		@objects = {}
		@idsOrder = original?.idsOrder or null
		@objectsOrder = []
		@objectsOrderSignalArr = null
		@isClone = !!original
		@isDeepClone = false
		@ready = false
		@objectsInitQueue = []
		@cache = original?.cache or Object.create(null)

		if original
			@createItem = original.createItem
			@cloneItem = original.cloneItem
			@cacheItem = original.cacheItem
		else	
			@createItem = utils.bindFunctionContext @createItem, @
			@cloneItem = utils.bindFunctionContext @cloneItem, @
			@cacheItem = utils.bindFunctionContext @cacheItem, @
		Object.preventExtensions @

	init: ->
		assert.notOk @ready
		assert.ok @isClone

		@objectsOrderSignalArr = utils.clone(@objectsOrder)
		@objectsOrderSignalArr.push null, null
		@ready = true

		# init objects
		{objectsInitQueue} = @
		i = 0; n = objectsInitQueue.length
		while i < n
			objectsInitQueue[i].apply objectsInitQueue[i+1], objectsInitQueue[i+2]
			i += 3
		@objectsInitQueue = null
		Object.freeze @

		# init extensions
		for id, item of @objects
			for extension in item._extensions
				if !extension.name and not extension._bindings?.when
					extension.enable()

		# init objects
		for id, item of @objects
			if item instanceof Renderer.Item
				item.onReady.emit()
				item.onReady.disconnectAll()

		return

	createItem: (parentComponent, opts) ->
		unless parentComponent instanceof Component
			opts = parentComponent
			parentComponent = null

		component = new Component @

		# clone and get items by ids
		newObjects = component.objects
		for id, item of @objects
			if item instanceof Renderer.Extension
				newObjects[item.id] = item.clone component

		for id, item of @objects
			if item instanceof Renderer.Item
				if item is @item
					newItem = component.item = item.clone component, opts
				else
					newItem = item.clone component
				newObjects[item.id] = newItem
				# for extension in newItem._extensions
				# 	if utils.has(@idsOrder, extension.id)
				# 		newObjects[extension.id] = extension
				# newObjects[item.id] = newItem

		# fill objectsOrder
		for object in @objectsOrder
			unless newObject = newObjects[object.id]
				newObject = newObjects[object.id] = object
			component.objectsOrder.push newObject

		# set parents
		for id, item of @objects
			newItem = newObjects[item.id]
			if newItem instanceof Renderer.Item and item._children
				for child in item._children
					if child.id
						newChild = newObjects[child.id]
						newChild.parent = newItem

		if parentComponent
			component.item._component = parentComponent

		assert.is component.idsOrder.length, component.objectsOrder.length

		component.init()
		component.item

	initClonedObject = (item, component) ->
		for extension in item._extensions
			if extension instanceof Renderer.Class
				for name, val of extension.changes._attributes
					if val instanceof Link
						cloneObj = val.getItem(component).clone(component)
						component.saveClonedObject cloneObj, val
						initClonedObject cloneObj, component
			if !extension.name and not extension._bindings?.when
				extension.enable()

		# init objects
		if item instanceof Renderer.Item
			item.onReady.emit()
			item.onReady.disconnectAll()

			for child in item.children
				initClonedObject child, component

		item

	cloneItem: (id) ->
		assert.isString id
		assert.notLengthOf id, 0

		if @cache[id]
			@cache[id].pop()
		else
			if id is @item.id
				@createItem()
			else
				component = new Component @
				component.item = @item
				component.objects = utils.clone @objects
				component.objectsOrder = utils.clone @objectsOrder
				component.objectsOrderSignalArr = utils.clone @objectsOrderSignalArr
				component.isDeepClone = true
				component.ready = true

				item = @objects[id]?.cloneDeep(component)

				# init extensions
				initClonedObject item, component

				item

	saveClonedObject: (object, oldObject) ->
		assert.ok @isDeepClone

		@objects[object.id] = object
		index = @objectsOrder.indexOf oldObject
		if index isnt -1
			@objectsOrder[index] = object
			@objectsOrderSignalArr[index] = object

		return

	cacheItem: (item) ->
		assert.instanceOf item, Renderer.Item
		assert.isString item.id
		assert.notLengthOf item.id, 0

		@cache[item.id] ?= []
		@cache[item.id].push item
		return

	@Link = class Link
		constructor: (@id) ->
			Object.preventExtensions @

		getItem: (component) ->
			obj = component.objects[@id]
			obj
