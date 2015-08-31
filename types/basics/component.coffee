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
		@fileName = opts?.fileName or original?.fileName or 'unknown'
		@objects = {}
		@idsOrder = original?.idsOrder or null
		@objectsOrder = []
		@objectsOrderSignalArr = null
		@isClone = !!original
		@isDeepClone = false
		@ready = false
		@objectsInitQueue = []
		@cache = original?.cache or Object.create(null)
		@parent = original
		@aliases = if original then Object.create(original.aliases) else {}

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

		# init extensions
		for id, item of @objects
			for extension in item._extensions
				if extension._component is @ and !extension.name and not extension._bindings?.when
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
				newObj = cloneItem obj, components, null, null, comp

		# initialize component
		comp.init()
		return

	cloneItem = (item, components, opts, optsComponent, parentComponent) ->
		# get cloned item component
		itemCompId = item._component.id
		unless component = components[itemCompId]
			newComp = true
			component = components[itemCompId] = new Component item._component

		# create default class in required component
		# used when main item (only this type can have opts) extends other item
		if optsComponent and opts
			clone = item.clone optsComponent, opts
			clone._component = component
		else
			clone = item.clone component, opts

		# extended item has more than one id, so remember it to the further cloning
		if opts?.id and item.id
			component.aliases[opts.id] = item.id

		# if it's an item (all items have to have an id),
		# let's save it in the cloned component
		if clone.id
			# if this item extends another (only main item - that's why opts),
			# we save it under the proper id's
			if (parentComponent isnt component or opts?.id) and (id = component.aliases[clone.id])
				if parentComponent isnt component
					parentComponent.setObject clone, clone.id
				component.setObject clone, id
			else
				component.setObject clone, clone.id

		# clone extensions of this object
		for ext in item._extensions
			# extension can be already cloned if it has an id
			cloneExt = components[ext._component.id]?.objects[ext.id]
			cloneExt ?= cloneItem ext, components, null, null, parentComponent
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
				cloneChild ?= cloneItem(child, components, null, null, component)
				cloneChild.parent = clone

			if firstChildren
				for child in firstChildren
					child.parent = clone

		# one item can have different extending items,
		# but their can't use the same component;
		# this function is recursive, so our deep component are not available for parents
		if newComp
			endComponentCloning component, components
			components[itemCompId] = null

		clone

	clone: (parentComponent, opts) ->
		unless parentComponent instanceof Component
			opts = parentComponent
			parentComponent = null

		component = new Component @

		components = {}
		components[component.id] = component
		if parentComponent
			components[parentComponent.id] = parentComponent

		component.item = cloneItem @item, components, opts, parentComponent, component

		endComponentCloning component, components

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

	# initClonedObject = (item, component) ->
	# 	for extension in item._extensions
	# 		if extension instanceof Renderer.Class
	# 			for name, val of extension.changes._attributes
	# 				if val instanceof Link
	# 					cloneObj = val.getItem(component).clone(component)
	# 					component.saveClonedObject cloneObj, val
	# 					initClonedObject cloneObj, component
	# 		if !extension.name and not extension._bindings?.when
	# 			extension.enable()

	# 	# init objects
	# 	if item instanceof Renderer.Item
	# 		item.onReady.emit()
	# 		item.onReady.disconnectAll()

	# 		for child in item.children
	# 			initClonedObject child, component

	# 	item

	# cloneItem: (id) ->
	# 	assert.isString id
	# 	assert.notLengthOf id, 0

	# 	if @cache[id]
	# 		@cache[id].pop()
	# 	else
	# 		if id is @item.id
	# 			@createItem()
	# 		else
	# 			component = new Component @
	# 			component.item = @item
	# 			component.objects = utils.clone @objects
	# 			component.objectsOrder = utils.clone @objectsOrder
	# 			component.objectsOrderSignalArr = utils.clone @objectsOrderSignalArr
	# 			component.isDeepClone = true
	# 			component.ready = true

	# 			item = @objects[id]?.cloneDeep(component)

	# 			# init extensions
	# 			initClonedObject item, component

	# 			item

	# saveClonedObject: (object, oldObject) ->
	# 	assert.ok @isDeepClone

	# 	@objects[object.id] = object
	# 	index = @objectsOrder.indexOf oldObject
	# 	if index isnt -1
	# 		@objectsOrder[index] = object
	# 		@objectsOrderSignalArr[index] = object

	# 	return

	# cacheItem: (item) ->
	# 	assert.instanceOf item, Renderer.Item
	# 	assert.isString item.id
	# 	assert.notLengthOf item.id, 0

	# 	@cache[item.id] ?= []
	# 	@cache[item.id].push item
	# 	return

	@Link = class Link
		constructor: (@id) ->
			Object.preventExtensions @

		getItem: (component) ->
			obj = component.objects[@id]
			obj
