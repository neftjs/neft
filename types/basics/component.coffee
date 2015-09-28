'use strict'

utils = require 'utils'
assert = require 'neft-assert'

module.exports = (Renderer, Impl, itemUtils) -> class Component
	constructor: (original, opts) ->
		unless original instanceof Component
			opts = original
			original = null

		if original?
			assert.instanceOf original, Component

		@id = original?.id or utils.uid()
		@item = null
		@itemId = original?.itemId or ''
		@fileName = opts?.fileName or original?.fileName or 'unknown'
		@objects = {}
		@idsOrder = original?.idsOrder or null
		@objectsOrder = []
		@objectsOrderSignalArr = null
		@isClone = !!original
		@isDeepClone = false
		@ready = false
		@mirror = false
		@objectsInitQueue = []
		@cache = original?.cache or Object.create(null)
		@parent = original

		# if original
			# @createItem = original.createItem
			# @cloneItem = original.cloneItem
			# @cacheItem = original.cacheItem
		# else	
		@clone = utils.bindFunctionContext @clone, @
		@createItem = utils.bindFunctionContext @createItem, @
		@createItem.getComponent = @clone
			# @cloneItem = utils.bindFunctionContext @cloneItem, @
			# @cacheItem = utils.bindFunctionContext @cacheItem, @
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

	initObjects: ->
		# init extensions
		for id, item of @objects
			for extension in item._extensions
				if extension._component.ready and !extension.name and not extension._bindings?.when
					extension.enable()

		# init objects
		for id, item of @objects
			if item instanceof Renderer.Item
				item.onReady.emit()
				item.onReady.disconnectAll()

		return

	endComponentCloning = (comp, components) ->
		# clone no children objects (e.g. links)
		for id, obj of comp.parent.objects
			unless comp.objects[id]
				newObj = cloneObject obj, components, comp

		# initialize component
		comp.init()
		return

	cloneObject = (item, components, parentComponent) ->
		# get cloned item component
		needsNewComp = false
		itemCompId = item._component.id
		unless component = components[itemCompId]
			needsNewComp = true
			component = components[itemCompId] = new Component item._component
			component.mirror = parentComponent.mirror

		# create default class in required component
		# used when main item (only this type can have opts) extends other item
		clone = item.clone component
		if item._component.item is item
			component.item = clone

		# if it's an item (all items have to have an id),
		# let's save it in the cloned component
		if clone.id
			# if this item extends another (only main item - that's why opts),
			# we save it under the proper id's
			if item._component.item is item
				if parentComponent isnt component
					parentComponent.setObject clone, parentComponent.itemId
				if not component.objects[component.itemId]
					component.setObject clone, component.itemId
			else
				component.setObject clone, clone.id

		# clone extensions of this object
		for ext in item._extensions
			# extension can be already cloned if it has an id
			cloneExt = components[ext._component.id]?.objects[ext.id]
			cloneExt ?= cloneObject ext, components, parentComponent
			cloneExt.target = clone

		if item instanceof Renderer.Item
			# if we extend another item,
			# we process it in reversed order (from top to bottom - basic item);
			# extending require that extended item is less important, that's why
			# we put his children at the bottom
			if clone.children.length
				firstChildren = Array::slice.call clone.children
				clone.children.clear()

			for child in item.children
				# child can be already cloned
				cloneChild = components[child._component.id]?.objects[child.id]
				cloneChild ?= cloneItem(child, components, component)
				cloneChild.parent = clone

			if firstChildren
				for child in firstChildren
					child.parent = clone

		clone

	cloneItem = (item, components, parentComponent) ->
		itemCompId = item._component.id
		needsNewComp = not components[itemCompId]
		clone = cloneObject item, components, parentComponent

		# one item can have different extending items,
		# but their can't use the same component;
		# this function is recursive, so our deep component are not available for parents
		if needsNewComp
			endComponentCloning clone._component, components
			if parentComponent.mirror
				clone._component.initObjects()
			components[itemCompId] = null

		clone

	clone: (parentComponent, itemOpts) ->
		unless parentComponent instanceof Component
			itemOpts = parentComponent
			parentComponent = null

		component = new Component @
		component.mirror = not parentComponent

		components = {}
		components[component.id] = component
		if parentComponent
			components[parentComponent.id] = parentComponent

		component.item = cloneItem @item, components, component

		if itemOpts
			itemUtils.Object.setOpts component.item, parentComponent, itemOpts

		for id, comp of components
			if comp?.isClone
				endComponentCloning comp, components
		if component.mirror
			component.initObjects()

		component

	setObject: (object, id) ->
		assert.isString id
		assert.notLengthOf id, 0
		assert.ok @parent.objects[id]
		assert.notOk @objects[id]

		@objects[id] = object

		index = @idsOrder.indexOf id
		if index isnt -1
			@objectsOrder[index] = object
		return

	createItem: (arg1, arg2) ->
		component = @clone arg1, arg2
		component.item

	cloneObject: (item, opts) ->
		assert.instanceOf item, itemUtils.Object
		assert.isString item.id
		assert.notLengthOf item.id, 0
		assert.ok @objects[item.id]

		{id} = item

		if @cache[id]
			@cache[id].pop()
		else
			if id is @item.id
				@createItem()
			else
				component = new Component @
				component.item = @item
				component.objectsOrderSignalArr = new Array @objectsOrder.length+2
				component.isDeepClone = true
				component.ready = true
				component.mirror = true

				components = {}
				components[component.id] = component
				clone = cloneItem item, components, component

				for key, val of @objects
					component.objects[key] ||= val
				for val, i in @objectsOrder
					component.objectsOrderSignalArr[i] = component.objectsOrder[i] ||= val

				opts?.beforeInitObjects? clone

				component.initObjects()

				clone

	setObjectById: (object, id) ->
		assert.instanceOf object, itemUtils.Object
		assert.isString id
		assert.ok @objects[id]

		index = @idsOrder.indexOf id
		@objects[id] = object
		@objectsOrder[index] = @objectsOrderSignalArr[index] = object
		object

	cacheObject: (item) ->
		assert.instanceOf item, itemUtils.Object
		assert.isString item.id
		assert.notLengthOf item.id, 0
		assert.ok @objects[item.id]

		@cache[item.id] ?= []
		@cache[item.id].push item
		return

	@Link = class Link
		constructor: (@id) ->
			Object.preventExtensions @

		getItem: (component) ->
			obj = component.objects[@id]
			obj
