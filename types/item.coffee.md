Renderer.Item
=============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	signal = require 'signal'
	Dict = require 'dict'
	List = require 'list'

	{isArray} = Array

	module.exports = (Renderer, Impl, itemUtils) -> class Item extends Dict
		@__name__ = 'Item'
		@__path__ = 'Renderer.Item'

		@SIGNALS = ['pointerClicked', 'pointerPressed', 'pointerReleased',
		            'pointerEntered', 'pointerExited', 'pointerWheel', 'pointerMove']

		Margin = require('./item/margin') Renderer, Impl, itemUtils
		Anchors = require('./item/anchors') Renderer, Impl, itemUtils
		Animations = require('./item/animations') Renderer, Impl, itemUtils

		@DATA =
			parent: null
			clip: false
			visible: true
			x: 0
			y: 0
			z: 0
			width: 0
			height: 0
			rotation: 0
			scale: 1
			opacity: 1
			state: null
			states: null
			anchors: Anchors.DATA
			margin: Margin.DATA

*Item* Item([*Object* options, *Array* children])
-------------------------------------------------

		constructor: (opts, children) ->
			# optional `opts` argument
			if arguments.length is 1 and isArray(opts)
				children = opts
				opts = undefined

			expect(@).toBe.any Item
			expect(arguments.length).not().toBe.greaterThan 2
			expect().defined(opts).toBe.simpleObject()
			expect().defined(children).toBe.array()

			# custom properties
			if opts?.properties?
				for propName in opts.properties
					itemUtils.defineProperty @, propName
				delete opts.properties

			# custom signals
			if opts?.signals?
				for signalName in opts.signals
					signal.create @, signalName
				delete opts.signals

			# initialization
			unless @hasOwnProperty '__hash__'
				utils.defineProperty @, '_impl', null, {}

				super Object.create(@constructor.DATA)
				Impl.createItem @, @constructor.__name__

			# fill
			itemUtils.fill @, opts

			# append children
			if children
				for child in children
					child.parent = @

*String* Item::id
-----------------

		utils.defineProperty @::, 'id', utils.ENUMERABLE, ->
			undefined
		, (val) ->
			expect(val).toBe.truthy().string()
			utils.defineProperty @, 'id', utils.ENUMERABLE, val

Item::ready()
-------------

		readyLazySignal = signal.createLazy @::, 'ready'

		readyLazySignal.onInitialized (item) ->
			setImmediate -> item.ready()

		onLazySignalInitialized = (item, signalName) ->
			Impl.attachItemSignal.call item, signalName, item[signalName]

		for signalName in Item.SIGNALS
			lazySignal = signal.createLazy @::, signalName
			lazySignal.onInitialized onLazySignalInitialized

*Object* Item::children
-----------------------

		utils.defineProperty @::, 'children', utils.ENUMERABLE, ->
			val = Object.create ChildrenObject
			utils.defineProperty val, 'length', utils.WRITABLE, 0
			utils.defineProperty @, 'children', utils.ENUMERABLE, val
			val
		, (val) ->
			expect(val).toBe.array()
			for item in val
				val.parent = @
			null

### Item::childrenChanged(*Object* children)

		signal.createLazy @::, Dict.getPropertySignalName('children')

		ChildrenObject = {}

### Item::children::inserted(*Integer* index, *Item* child)

		signal.createLazy ChildrenObject, 'inserted'

### Item::children::popped(*Integer* index, *Item* child)

		signal.createLazy ChildrenObject, 'popped'

*[Item]* Item::parent
---------------------

### Item::parentChanged(*Item* oldParent)

		itemUtils.defineProperty @::, 'parent', null, (_super) -> (val) ->
			if old = @parent
				index = Array::indexOf.call old.children, @
				Array::splice.call old.children, index, 1
				old.childrenChanged? old.children
				old.children.popped? index, @

			if val?
				expect(val).toBe.any Item
				length = Array::push.call val.children, @
				val.childrenChanged? val.children
				val.children.inserted? length - 1, @

			_super.call @, val
			Impl.setItemParent.call @, val

*Boolean* Item::visible
-----------------------

### Item::visibleChanged(*Boolean* oldValue)

		itemUtils.defineProperty @::, 'visible', null, (_super) -> (val) ->
			expect(val).toBe.boolean()
			_super.call @, val
			Impl.setItemVisible.call @, val

*Boolean* Item::clip
--------------------

### Item::clipChanged(*Boolean* oldValue)

		itemUtils.defineProperty @::, 'clip', null, (_super) -> (val) ->
			expect(val).toBe.boolean()
			_super.call @, val
			Impl.setItemClip.call @, val

*Float* Item::width
-------------------

### Item::widthChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'width', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setItemWidth.call @, val

*Float* Item::height
--------------------

### Item::heightChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'height', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setItemHeight.call @, val

*Float* Item::x
---------------

### Item::xChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'x', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setItemX.call @, val

*Float* Item::y
---------------

### Item::yChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'y', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setItemY.call @, val

*Float* Item::z
---------------

### Item::zChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'z', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setItemZ.call @, val

*Float* Item::scale
-------------------

### Item::scaleChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'scale', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setItemScale.call @, val

*Float* Item::rotation
----------------------

### Item::rotationChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'rotation', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setItemRotation.call @, val

*Float* Item::opacity
---------------------

### Item::opacityChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'opacity', null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setItemOpacity.call @, val

		require('./item/state') Renderer, Impl, @, itemUtils

*Item.Margin* Item::margin
--------------------------

		Renderer.State.supportObjectProperty 'margin'
		utils.defineProperty @::, 'margin', utils.ENUMERABLE, ->
			utils.defineProperty @, 'margin', utils.ENUMERABLE, val = new Margin(@)
			val
		, (val) ->
			expect(val).toBe.simpleObject()
			utils.merge @margin, Margin.DATA
			utils.merge @margin, val

### Item::marginChanged(*Item.Margin* margin)

		signal.createLazy @::, Dict.getPropertySignalName 'margin'

*Item.Anchors* Item::anchors
----------------------------

		Renderer.State.supportObjectProperty 'anchors'
		utils.defineProperty @::, 'anchors', utils.ENUMERABLE, ->
			utils.defineProperty @, 'anchors', utils.ENUMERABLE, val = new Anchors(@)
			val
		, (val) ->
			expect(val).toBe.simpleObject()
			utils.merge @anchors, Anchors.DATA
			utils.merge @anchors, val

*Item.Animations* Item::animations
----------------------------------

		Renderer.State.supportObjectProperty 'animations'
		utils.defineProperty @::, 'animations', utils.ENUMERABLE, ->
			utils.defineProperty @, 'animations', utils.ENUMERABLE, val = new Animations(@)
			val
		, null

		defineProperty: (propName, defVal=null) ->
			itemUtils.defineProperty @, propName
			@_data[propName] = defVal
			@

Item::clear()
-------------

		clear: ->
			while child = @children[0]
				child.parent = null
			null

*Item* Item::clone()
--------------------

		clone: ->
			throw "Not implemented"

*Item* Item::cloneDeep()
------------------------

		cloneDeep: ->
			throw "Not implemented"
