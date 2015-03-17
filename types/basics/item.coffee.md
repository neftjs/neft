Basic items/Item
================

	'use strict'

	assert = require 'neft-assert'
	utils = require 'utils'
	signal = require 'signal'
	List = require 'list'

	{isArray} = Array
	SignalsEmitter = signal.Emitter

	assert = assert.scope 'Renderer.Item'

	module.exports = (Renderer, Impl, itemUtils) -> class Item extends itemUtils.Object
		@__name__ = 'Item'
		@__path__ = 'Renderer.Item'

*Item* Item()
-------------

This is a base class for everything which is visible.

		constructor: ->
			assert.instanceOf @, Item, 'ctor ...'

			@constructor = @constructor
			@$ = null
			@_impl = null
			@_parent = null
			@_sourceItem = null
			@_children = null
			@_x = 0
			@_y = 0
			@_z = 0
			@_width = 0
			@_height = 0
			@_visible = true
			@_clip = false
			@_scale = 1
			@_rotation = 0
			@_opacity = 1
			@_linkUri = ''
			@_fill = null
			@_anchors = null
			@_document = null
			@_keys = null
			@_pointer = null
			@_margin = null
			@_states = null
			@_stateExtensions = null

			super()

			Impl.createItem @, @constructor.__name__

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

*Signal* Item::update(*Integer* miliseconds)
--------------------------------------------

		signal.Emitter.createSignal @, 'update', null, null, do ->
			now = Date.now()
			items = []

			frame = ->
				oldNow = now
				now = Date.now()
				ms = now - oldNow

				for item in items
					item.update ms
				requestAnimationFrame frame

			requestAnimationFrame? frame

			(item) ->
				items.push item

*Object* Item::children
-----------------------

		utils.defineProperty @::, 'children', null, ->
			@_children ?= new ChildrenObject(@)
		, (val) ->
			assert.isArray val, '::children setter ...'
			@clear()
			for item in val
				val.parent = @
			return

### *Signal* Item::childrenChanged(*Object* children)

		signal.Emitter.createSignal @, 'childrenChanged'

		class ChildrenObject extends signal.Emitter
			constructor: (ref) ->
				@_ref = ref
				@length = 0
				super()

			index: (val) -> Array::indexOf.call @, val
			has: (val) -> @index(val) isnt -1

### *Signal* Item.children::inserted(*Item* child, *Integer* index)

		signal.Emitter.createSignal ChildrenObject, 'inserted'

### *Signal* Item.children::popped(*Item* child, *Integer* index)

		signal.Emitter.createSignal ChildrenObject, 'popped'

*Item* Item::parent = null
--------------------------

### *Signal* Item::parentChanged(*Item* oldParent)

		{indexOf, splice, push} = Array::

		itemUtils.defineProperty
			constructor: @
			name: 'parent'
			defaultValue: null
			implementation: Impl.setItemParent
			setter: (_super) -> (val) ->
				if val?._sourceItem
					val = val._sourceItem

				old = @_parent
				if old is val
					return

				if old
					index = indexOf.call old._children, @
					splice.call old._children, index, 1

				if val?
					assert.instanceOf val, Item, '::parent setter ...'
					length = push.call val.children, @

				_super.call @, val

				if old
					old.childrenChanged old.children
					old.children.popped @, index

				if val?
					val.childrenChanged val.children
					val.children.inserted @, length - 1

				return

*Boolean* Item::visible = true
------------------------------

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
			defaultValue: true
			implementation: Impl.setItemVisible
			developmentSetter: (val) ->
				assert.isBoolean val, '::visible setter ...'

*Boolean* Item::clip = false
----------------------------

### *Signal* Item::clipChanged(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'clip'
			defaultValue: false
			implementation: Impl.setItemClip
			developmentSetter: (val) ->
				assert.isBoolean val, '::clip setter ...'

*Float* Item::width = 0
-----------------------

### *Signal* Item::widthChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'width'
			defaultValue: 0
			implementation: Impl.setItemWidth
			developmentSetter: (val) ->
				assert.isFloat val, '::width setter ...'

*Float* Item::height = 0
------------------------

### *Signal* Item::heightChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'height'
			defaultValue: 0
			implementation: Impl.setItemHeight
			developmentSetter: (val) ->
				assert.isFloat val, '::height setter ...'

*Float* Item::x = 0
-------------------

### *Signal* Item::xChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'x'
			defaultValue: 0
			implementation: Impl.setItemX
			developmentSetter: (val) ->
				assert.isFloat val, '::x setter ...'

*Float* Item::y = 0
-------------------

### *Signal* Item::yChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'y'
			defaultValue: 0
			implementation: Impl.setItemY
			developmentSetter: (val) ->
				assert.isFloat val, '::y setter ...'

*Float* Item::z = 0
-------------------

### *Signal* Item::zChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'z'
			defaultValue: 0
			implementation: Impl.setItemZ
			developmentSetter: (val) ->
				assert.isFloat val, '::z setter ...'

*Float* Item::scale = 1
-----------------------

### *Signal* Item::scaleChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'scale'
			defaultValue: 1
			implementation: Impl.setItemScale
			developmentSetter: (val) ->
				assert.isFloat val, '::scale setter ...'

*Float* Item::rotation = 0
--------------------------

### *Signal* Item::rotationChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'rotation'
			defaultValue: 0
			implementation: Impl.setItemRotation
			developmentSetter: (val) ->
				assert.isFloat val, '::rotation setter ...'

*Float* Item::opacity = 1
-------------------------

### *Signal* Item::opacityChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'opacity'
			defaultValue: 1
			implementation: Impl.setItemOpacity
			developmentSetter: (val) ->
				assert.isFloat val, '::opacity setter ...'

*String* Item::linkUri = ''
---------------------------

This attribute points to the URI which will be used when user clicks on this item.

It's required for browsers, where link URIs should be known publicly.

### *Signal* Item::linkUriChanged(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'linkUri'
			defaultValue: ''
			implementation: Impl.setItemLinkUri
			developmentSetter: (val) ->
				assert.isString val, '::linkUri setter ...'

Item::overlap(*Renderer.Item* item)
-----------------------------------

This method checks whether two items are overlapped.

		overlap: (item) ->
			assert.instanceOf item, Item

			Impl.doItemOverlap.call @, item

Item::clear()
-------------

Removes all children from a node.

		clear: ->
			while child = @children[0]
				child.parent = null
			return

Item::clone()
-------------

		clone: ->
			ctor = @constructor
			if (ctor::) is (Item::) or (ctor::) instanceof Item
				clone = new ctor
			else
				clone = ctor()

			clone.x = @_x
			clone.y = @_y
			clone.z = @_z
			clone.width = @_width
			clone.height = @_height
			clone.clip = @_clip
			clone.visible = @_visible
			clone.linkUri = @_linkUri
			clone.scale = @_scale
			clone.rotation = @_rotation
			clone.opacity = @_opacity

			clone

		require('./item/margin') Renderer, Impl, itemUtils, Item
		require('./item/fill') Renderer, Impl, itemUtils, Item
		require('./item/anchors') Renderer, Impl, itemUtils, Item
		require('./item/property') Renderer, Impl, itemUtils, Item
		require('./item/signal') Renderer, Impl, itemUtils, Item
		require('./item/pointer') Renderer, Impl, itemUtils, Item
		require('./item/keys') Renderer, Impl, itemUtils, Item
		require('./item/document') Renderer, Impl, itemUtils, Item

		Item
