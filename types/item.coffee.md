Renderer.Item
=============

	'use strict'

	assert = require 'asserts'
	utils = require 'utils'
	signal = require 'signal'
	List = require 'list'

	assert = assert.scope 'Renderer.Item'

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

			assert.instanceOf @, Item, ' ctor ...'
			assert.operator arguments.length, '<=', 2, ' ctor arguments ...'
			assert.isDefined opts, ' ctor options argument ...' if opts?
			asser.isArray children, ' ctor children argument ...' if children?

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
			assert.isArray val, '::children setter ...'
			for item in val
				val.parent = @
			null

### Item::childrenChanged(*Object* children)

		signal.createLazy @::, 'childrenChanged'

		ChildrenObject = {}

### Item::children::inserted(*Item* child, *Integer* index)

		signal.createLazy ChildrenObject, 'inserted'

### Item::children::popped(*Item* child, *Integer* index)

		signal.createLazy ChildrenObject, 'popped'

*[Item]* Item::parent
---------------------

### Item::parentChanged(*Item* oldParent)

		itemUtils.defineProperty @::, 'parent', Impl.setItemParent, null, (_super) -> (val) ->
			old = @parent
			if old is val
				return

			if old
				index = Array::indexOf.call old.children, @
				Array::splice.call old.children, index, 1
				old.childrenChanged? old.children
				old.children.popped? @, index

			if val?
				assert.instanceOf val, Item, '::parent setter ...'
				length = Array::push.call val.children, @
				val.childrenChanged? val.children
				val.children.inserted? @, length - 1

			_super.call @, val

*Boolean* Item::visible
-----------------------

### Item::visibleChanged(*Boolean* oldValue)

		itemUtils.defineProperty @::, 'visible', Impl.setItemVisible, null, (_super) -> (val) ->
			assert.isBoolean val, '::visible setter ...'
			_super.call @, val

*Boolean* Item::clip
--------------------

### Item::clipChanged(*Boolean* oldValue)

		itemUtils.defineProperty @::, 'clip', Impl.setItemClip, null, (_super) -> (val) ->
			assert.isBoolean val, '::clip setter ...'
			_super.call @, val

*Float* Item::width
-------------------

### Item::widthChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'width', Impl.setItemWidth, null, (_super) -> (val) ->
			assert.isFloat val, '::width setter ...'
			_super.call @, val

*Float* Item::height
--------------------

### Item::heightChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'height', Impl.setItemHeight, null, (_super) -> (val) ->
			assert.isFloat val, '::height setter ...'
			_super.call @, val

*Float* Item::x
---------------

### Item::xChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'x', Impl.setItemX, null, (_super) -> (val) ->
			assert.isFloat val, '::x setter ...'
			_super.call @, val

*Float* Item::y
---------------

### Item::yChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'y', Impl.setItemY, null, (_super) -> (val) ->
			assert.isFloat val, '::y setter ...'
			_super.call @, val

*Float* Item::z
---------------

### Item::zChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'z', Impl.setItemZ, null, (_super) -> (val) ->
			assert.isFloat val, '::z setter ...'
			_super.call @, val

*Float* Item::scale
-------------------

### Item::scaleChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'scale', Impl.setItemScale, null, (_super) -> (val) ->
			assert.isFloat val, '::scale setter ...'
			_super.call @, val

*Float* Item::rotation
----------------------

### Item::rotationChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'rotation', Impl.setItemRotation, null, (_super) -> (val) ->
			assert.isFloat val, '::rotation setter ...'
			_super.call @, val

*Float* Item::opacity
---------------------

### Item::opacityChanged(*Float* oldValue)

		itemUtils.defineProperty @::, 'opacity', Impl.setItemOpacity, null, (_super) -> (val) ->
			assert.isFloat val, '::opacity setter ...'
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
			assert.isPlainObject val, '::margin setter ...'
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
			assert.isPlainObject val, '::anchors setter ...'
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
