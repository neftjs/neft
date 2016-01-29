'use strict'

utils = require 'utils'
signal = require 'signal'
assert = require 'assert'

module.exports = (Renderer, Impl, itemUtils) -> class Component

	@getCloneFunction = (func, name) ->
		if typeof func is 'function'
			func
		else if func and typeof func._main is 'function'
			func._main
		else
			throw new Error "'#{name}' is not an item definition"

	constructor: (original, opts) ->
		unless original instanceof Component
			opts = original
			original = null

		if original?
			assert.instanceOf original, Component

			while original.parent
				original = original.parent

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
		@belongsToComponent = null
		@objectsInitQueue = []
		@parent = original
		@disabledObjects = original?.disabledObjects or Object.create(null)

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

		@onObjectChange = null

		Object.preventExtensions @

	initSignalArr = ->
		for id, i in @idsOrder
			@objectsOrder[i] ||= @objects[id] or null

		@objectsOrderSignalArr = utils.clone(@objectsOrder)
		@objectsOrderSignalArr.push null, null

	initAsEmptyDefinition: ->
		initSignalArr.call @
		Object.freeze @
		@initObjects()
		return

	init: ->
		assert.notOk @ready
		assert.ok @isClone

		@onObjectChange ?= signal.create()
		initSignalArr.call @
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
			if @objects.hasOwnProperty(id)
				for extension in item._extensions
					if !extension.name and not extension._bindings?.when
						extension.enable()

		# init objects
		for id, item of @objects
			if @objects.hasOwnProperty(id) and item instanceof Renderer.Item and id isnt @itemId
				item.onReady.emit()

		return

	endComponentCloning = (comp, components, createdComponents) ->
		# clone no children objects (e.g. links)
		for id, obj of comp.parent.objects
			if not comp.objects[id] and id isnt comp.itemId and not comp.disabledObjects[id]
				newObj = cloneObject obj, components, createdComponents, comp

		# initialize component
		comp.init()
		return

	cloneObject = (item, components, createdComponents, parentComponent) ->
		# get cloned item component
		needsNewComp = false
		itemCompId = item._component.id
		unless component = components[itemCompId]
			needsNewComp = true
			component = components[itemCompId] = new Component item._component
			if belongsToComponent = item._component.belongsToComponent
				component.belongsToComponent = components[belongsToComponent.id]
			component.mirror = parentComponent.mirror
			createdComponents.push component

		# create default class in required component
		# used when main item (only this type can have opts) extends other item
		clone = item.clone component
		if item._component.item is item
			component.item = clone

		# save object in the cloned component
		if clone.id
			if item._component.item is item
				if belongsToComponent = item._component.belongsToComponent
					components[belongsToComponent.id].setObject clone, clone.id
				component.setObject clone, component.itemId
			else
				component.setObject clone, clone.id

		# clone extensions of this object
		for ext in item._extensions
			# extension can be already cloned if it has an id
			cloneExt = components[ext._component.id]?.objects[ext.id]
			cloneExt ?= cloneObject ext, components, createdComponents, parentComponent
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
				cloneChild ?= cloneItem(child, components, createdComponents, component)
				cloneChild.parent = clone

			if firstChildren
				for child in firstChildren
					child.parent = clone

		clone

	cloneItem = (item, components, createdComponents, parentComponent) ->
		itemCompId = item._component.id
		needsNewComp = not components[itemCompId]
		clone = cloneObject item, components, createdComponents, parentComponent

		# one item can have different extending items,
		# but their can't use the same component;
		# this function is recursive, so our deep component are not available for parents
		if needsNewComp
			endComponentCloning components[itemCompId], components, createdComponents
			components[itemCompId] = null

		clone

	clone: (parentComponent, itemOpts) ->
		unless parentComponent instanceof Component
			itemOpts = parentComponent
			parentComponent = null

		component = new Component @
		component.mirror = not parentComponent
		component.belongsToComponent = parentComponent

		components = {}
		components[component.id] = component
		if parentComponent
			components[parentComponent.id] = parentComponent
		createdComponents = [component]

		item = cloneItem @item, components, createdComponents, component

		for comp in createdComponents
			unless comp.item
				comp.item = item
				unless comp.objects[comp.itemId]
					comp.setObject item, comp.itemId
		`//<development>`
		Object.freeze createdComponents
		`//</development>`
		if itemOpts
			itemUtils.Object.setOpts component.item, parentComponent, itemOpts
		# for comp in createdComponents
		# 	components[comp.id] = comp
		# 	endComponentCloning comp, components, createdComponents
		for comp in createdComponents
			unless comp.ready
				endComponentCloning comp, components, createdComponents
		if component.mirror
			for comp in createdComponents
				assert.ok comp.ready
				comp.initObjects()
		item.onReady.emit()

		component

	setObject: (object, id) ->
		assert.isString id
		assert.notLengthOf id, 0
		assert.ok @parent.objects[id]
		assert.notOk @objects.hasOwnProperty(id)

		@objects[id] = object

		index = @idsOrder.indexOf id
		if index isnt -1
			@objectsOrder[index] = object
		return

	createItem: (arg1, arg2) ->
		component = @clone arg1, arg2
		component.item

	cloneRawObject: (item, opts=0) ->
		assert.instanceOf item, itemUtils.Object
		assert.isString item.id
		assert.notLengthOf item.id, 0
		assert.ok item.id isnt @itemId
		assert.ok @objects[item.id] or @parent?.objects[item.id]

		{id} = item

		if id is @itemId
			clone = @createItem()
		else
			component = new Component @
			component.objects = Object.create @objects
			component.item = @item
			component.objectsOrderSignalArr = new Array @objectsOrder.length+2
			component.isDeepClone = true
			component.ready = true
			component.mirror = true

			components = {}
			components[component.id] = component
			createdComponents = [component]
			clone = cloneItem item, components, createdComponents, component

			for val, i in @idsOrder
				component.objectsOrder[i] = component.objectsOrderSignalArr[i] ||= @objectsOrder[i]

		clone

	cloneObject: (item, opts) ->
		clone = @cloneRawObject item, opts
		clone._component.initObjects()
		clone

	cloneComponentObject: ->
		comp = new Component @
		comp.objects = Object.create @objects
		comp.item = @item
		comp.objectsOrder = Object.create @objectsOrder
		comp.objectsOrderSignalArr = Object.create @objectsOrderSignalArr
		comp.onObjectChange = @onObjectChange
		comp.isDeepClone = true
		comp.ready = true
		comp.mirror = true
		assert.is comp.objectsOrder.length, comp.idsOrder.length
		comp

	setObjectById: (object, id) ->
		assert.instanceOf object, itemUtils.Object
		assert.isString id
		assert.ok object.id is id
		assert.ok @objects[id] or @parent?.objects[id]

		if (oldVal = @objects[id]) is object
			return

		@objects[id] = object
		index = @idsOrder.indexOf id
		if index isnt -1
			@objectsOrder[index] = @objectsOrderSignalArr[index] = object
			@onObjectChange?.emit id, oldVal

		object

	@Link = class Link
		constructor: (@id) ->
			Object.preventExtensions @

		getItem: (component) ->
			obj = component.objects[@id]
			obj
