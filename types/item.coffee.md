Renderer.Item
=============

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	signal = require 'signal'
	List = require 'list'

	{isArray} = Array

	module.exports = (Renderer, Impl, itemUtils) -> class Item
		@__name__ = 'Item'
		@__path__ = 'Renderer.Item'

		@SIGNALS = ['pointerClicked', 'pointerPressed', 'pointerReleased',
		            'pointerEntered', 'pointerExited', 'pointerWheel', 'pointerMove']

		Margin = require('./item/margin') Renderer, Impl, itemUtils
		Anchors = require('./item/anchors') Renderer, Impl, itemUtils
		Animations = require('./item/animations') Renderer, Impl, itemUtils
		Transitions = require('./item/transitions') Renderer, Impl, itemUtils

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
				utils.defineProperty @, '__hash__', null, utils.uid()

				data = Object.create(@constructor.DATA)
				utils.defineProperty @, '_data', null, data

				utils.defineProperty @, '_impl', null, {}
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

		signal.createLazy @::, 'childrenChanged'

		ChildrenObject = {}

### Item::children::inserted(*Integer* index, *Item* child)

		signal.createLazy ChildrenObject, 'inserted'

### Item::children::popped(*Integer* index, *Item* child)

		signal.createLazy ChildrenObject, 'popped'

*[Item]* Item::parent
---------------------

### Item::parentChanged(*Item* oldParent)

		itemUtils.defineProperty @::, 'parent', Impl.setItemParent, null, (_super) -> (val) ->
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

*Boolean* Item::visible
-----------------------

### Item::visibleChanged(*Boolean* oldValue)

		itemUtils.defineProperty @::, 'visible', Impl.setItemVisible, null, (_super) -> (val) ->
			expect(val).toBe.boolean()
			_super.call @, val

*Boolean* Item::clip
--------------------

### Item::clipChanged(*Boolean* oldValue)

		itemUtils.defineProperty @::, 'clip', Impl.setItemClip, null, (_super) -> (val) ->
			expect(val).toBe.boolean()
			_super.call @, val

*Float* Item::width
-------------------

### Item::widthChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'width', Impl.setItemWidth, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val

*Float* Item::height
--------------------

### Item::heightChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'height', Impl.setItemHeight, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val

*Float* Item::x
---------------

### Item::xChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'x', Impl.setItemX, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val

*Float* Item::y
---------------

### Item::yChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'y', Impl.setItemY, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val

*Float* Item::z
---------------

### Item::zChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'z', Impl.setItemZ, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val

*Float* Item::scale
-------------------

### Item::scaleChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'scale', Impl.setItemScale, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val

*Float* Item::rotation
----------------------

### Item::rotationChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'rotation', Impl.setItemRotation, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val

*Float* Item::opacity
---------------------

### Item::opacityChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'opacity', Impl.setItemOpacity, null, (_super) -> (val) ->
			expect(val).toBe.float()
			_super.call @, val

		require('./item/state') Renderer, Impl, @, itemUtils

*Item.Margin* Item::margin
--------------------------

### Item::marginChanged(*Item.Margin* margin)

		Renderer.State.supportObjectProperty 'margin'
		itemUtils.defineProperty @::, 'margin', null, ((_super) -> ->
			if @_data.margin is Margin.DATA
				@_data.margin = new Margin(@)
			_super.call @
		), (_super) -> (val) ->
			_super.call @, @margin
			expect(val).toBe.simpleObject()
			utils.merge @margin, Margin.DATA
			utils.merge @margin, val

*Item.Anchors* Item::anchors
----------------------------

### Item::anchorsChanged(*Item.Anchors* anchors)

		Renderer.State.supportObjectProperty 'anchors'
		itemUtils.defineProperty @::, 'anchors', null, ((_super) -> ->
			if @_data.anchors is Anchors.DATA
				@_data.anchors = new Anchors(@)
			_super.call @
		), (_super) -> (val) ->
			_super.call @, @anchors
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

*Item.Transitions* Item::transitions
------------------------------------

		Renderer.State.supportObjectProperty 'transitions'
		utils.defineProperty @::, 'transitions', utils.ENUMERABLE, ->
			utils.defineProperty @, 'transitions', utils.ENUMERABLE, val = new Transitions(@)
			val
		, (val) ->
			{transitions} = @
			if Array.isArray(val)
				for elem in val
					transitions.append elem
			else
				transitions.append val
			return

Item::clear()
-------------

		clear: ->
			while child = @children[0]
				child.parent = null
			@

*Item* Item::clone()
--------------------

		clone: ->
			throw "Not implemented"

*Item* Item::cloneDeep()
------------------------

		cloneDeep: ->
			throw "Not implemented"
