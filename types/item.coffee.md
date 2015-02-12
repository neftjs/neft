Basic elements/Item
===================

	'use strict'

	assert = require 'neft-assert'
	utils = require 'utils'
	signal = require 'signal'
	List = require 'list'

	{isArray} = Array
	SignalsEmitter = signal.Emitter

	assert = assert.scope 'Renderer.Item'

	module.exports = (Renderer, Impl, itemUtils) -> class Item extends signal.Emitter
		@__name__ = 'Item'
		@__path__ = 'Renderer.Item'

		Margin = require('./item/margin') Renderer, Impl, itemUtils
		Anchors = require('./item/anchors') Renderer, Impl, itemUtils
		Animations = require('./item/animations') Renderer, Impl, itemUtils
		Transitions = require('./item/transitions') Renderer, Impl, itemUtils

		itemUtils.initConstructor @,
			data:
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
				state: ''
				linkUri: ''

*Item* Item([*Object* options, *Array* children])
-------------------------------------------------

		constructor: (opts, children) ->
			# optional `opts` argument
			if isArray(opts) and not children?
				children = opts
				opts = undefined

			assert.instanceOf @, Item, 'ctor ...'
			assert.isDefined opts, 'ctor options argument ...' if opts?
			assert.isArray children, 'ctor children argument ...' if children?

			# initialization
			unless @__hash__
				super()
				itemUtils.initObject @, Impl.createItem

			if opts?
				# initialize states
				if opts.states?
					@states

				# custom properties
				if opts.properties?
					for propName in opts.properties
						unless propName of @
							itemUtils.defineProperty
								object: @
								name: propName
					delete opts.properties

				# custom signals
				if opts.signals?
					for signalName in opts.signals
						unless signalName of @
							signal.create @, signalName
					delete opts.signals

				# fill
				itemUtils.fill @, opts

			# append children
			if children
				for child in children
					child.parent = @

*Signal* Item::ready()
----------------------

This signal is called when the *Renderer.Item* is ready, that is, all
properties have been set and it's ready to use.

This signal is asynchronous.

```style
Rectangle {
\  width: 200
\  height: 50
\  color: 'green'
\
\  Rectangle {
\  	width: parent.width / 2
\  	height: parent.height / 2
\  	color: 'yellow'
\  	onReady: function(){
\  	  console.log(this.width, this.height);
\  	  // 100, 25
\  	}
\  }
}
```

		readyLazySignal = signal.createLazy @::, 'ready'

		readyLazySignal.onInitialized (item) ->
			setImmediate -> item.ready()

*Signal* Item::pointerClicked(*Object* event)
---------------------------------------------

*Signal* Item::pointerPressed(*Object* event)
---------------------------------------------

*Signal* Item::pointerReleased(*Object* event)
----------------------------------------------

*Signal* Item::pointerEntered(*Object* event)
---------------------------------------------

*Signal* Item::pointerExited(*Object* event)
--------------------------------------------

*Signal* Item::pointerWheel(*Object* event)
-------------------------------------------

*Signal* Item::pointerMove(*Object* event)
------------------------------------------

		onLazySignalInitialized = (item, signalName) ->
			Impl.attachItemSignal.call item, signalName, item[signalName]

		@SIGNALS = ['pointerClicked', 'pointerPressed', 'pointerReleased',
		            'pointerEntered', 'pointerExited', 'pointerWheel', 'pointerMove']

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

### *Signal* Item::childrenChanged(*Object* children)

		signal.createLazy @::, 'childrenChanged'

		ChildrenObject = {}

### *Signal* Item.children::inserted(*Item* child, *Integer* index)

		signal.createLazy ChildrenObject, 'inserted'

### *Signal* Item.children::popped(*Item* child, *Integer* index)

		signal.createLazy ChildrenObject, 'popped'

*Item* Item::parent
-------------------

### *Signal* Item::parentChanged(*Item* oldParent)

		itemUtils.defineProperty
			constructor: @
			name: 'parent'
			implementation: Impl.setItemParent
			setter: (_super) -> (val) ->
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

Determines whether an item is visible or not.

```style
Item {
\  width: 100
\  height: 100
\
\  onPointerClicked: function(){
\  	rect.visible = !rect.visible;
\  	text.text = rect.visible ? "Click to hide" : "Click to show";
\  }
\
\  Rectangle {
\  	id: rect
\  	anchors.fill: parent
\  	color: 'blue'
\  }
\
\  Text {
\  	id: text
\  	text: "Click to hide"
\  	anchors.centerIn: parent
\  }
}
```

### *Signal* Item::visibleChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'visible'
			implementation: Impl.setItemVisible
			developmentSetter: (val) ->
				assert.isBoolean val, '::visible setter ...'

*Boolean* Item::clip
--------------------

### *Signal* Item::clipChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'clip'
			implementation: Impl.setItemClip
			developmentSetter: (val) ->
				assert.isBoolean val, '::clip setter ...'

*Float* Item::width
-------------------

### *Signal* Item::widthChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'width'
			implementation: Impl.setItemWidth
			developmentSetter: (val) ->
				assert.isFloat val, '::width setter ...'

*Float* Item::height
--------------------

### *Signal* Item::heightChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'height'
			implementation: Impl.setItemHeight
			developmentSetter: (val) ->
				assert.isFloat val, '::height setter ...'

*Float* Item::x
---------------

### *Signal* Item::xChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'x'
			implementation: Impl.setItemX
			developmentSetter: (val) ->
				assert.isFloat val, '::x setter ...'

*Float* Item::y
---------------

### *Signal* Item::yChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'y'
			implementation: Impl.setItemY
			developmentSetter: (val) ->
				assert.isFloat val, '::y setter ...'

*Float* Item::z
---------------

### *Signal* Item::zChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'z'
			implementation: Impl.setItemZ
			developmentSetter: (val) ->
				assert.isFloat val, '::z setter ...'

*Float* Item::scale
-------------------

### *Signal* Item::scaleChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'scale'
			implementation: Impl.setItemScale
			developmentSetter: (val) ->
				assert.isFloat val, '::scale setter ...'

*Float* Item::rotation
----------------------

### *Signal* Item::rotationChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'rotation'
			implementation: Impl.setItemRotation
			developmentSetter: (val) ->
				assert.isFloat val, '::rotation setter ...'

*Float* Item::opacity = 1
-------------------------

### *Signal* Item::opacityChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'opacity'
			implementation: Impl.setItemOpacity
			developmentSetter: (val) ->
				assert.isFloat val, '::opacity setter ...'

		require('./item/state') Renderer, Impl, @, itemUtils

*String* Item::linkUri = ''
---------------------------

This attribute points to the URI which will be used when user clicks on this item.

It's required for browsers, where link URIs should be known publicly.

### *Signal* Item::linkUriChanged(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'linkUri'
			implementation: Impl.setItemLinkUri
			developmentSetter: (val) ->
				assert.isString val, '::linkUri setter ...'

*Item.Margin* Item::margin
--------------------------

### *Signal* Item::marginChanged(*Item.Margin* margin)

		itemUtils.defineProperty
			constructor: @
			name: 'margin'
			valueConstructor: Margin

*Item.Anchors* Item::anchors
----------------------------

### *Signal* Item::anchorsChanged(*Item.Anchors* anchors)

		itemUtils.defineProperty
			constructor: @
			name: 'anchors'
			valueConstructor: Anchors

*Item.Animations* Item::animations
----------------------------------

### *Signal* Item::animationsChanged(*Item.Animations* animations)

		itemUtils.defineProperty
			constructor: @
			name: 'animations'
			valueConstructor: Animations

*Item.Transitions* Item::transitions
------------------------------------

### *Signal* Item::transitionsChanged(*Item.Transitions* transitions)

		itemUtils.defineProperty
			constructor: @
			name: 'transitions'
			valueConstructor: Transitions

Item::clear()
-------------

Removes all children from a node.

		clear: ->
			while child = @children[0]
				child.parent = null
			return
