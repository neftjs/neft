Scrollable @class
==========

	'use strict'

	utils = require 'utils'
	signal = require 'signal'
	assert = require 'assert'

	module.exports = (Renderer, Impl, itemUtils) -> class Scrollable extends Renderer.Item
		@__name__ = 'Scrollable'
		@__path__ = 'Renderer.Scrollable'

		# @createDefaultVerticalScrollbar = ->
		# 	scrollbar = new Renderer.Item
		# 	scrollbar.createProperty 'lastEvent'
		# 	scrollbar.createProperty 'pressed'
		# 	scrollbar.createProperty 'pointerMoveHandler'
		# 	scrollbar.createProperty 'pointerReleasedHandler'
		# 	scrollbar.$.pressed = false
		# 	scrollbar.width = 8
		# 	scrollbar.createBinding 'height', [
		# 		[['this', 'parent'], 'height'],
		# 		'/',
		# 		[[['this', 'parent'], 'contentItem'], 'height'],
		# 		'*',
		# 		[['this', 'parent'], 'height']
		# 	]
		# 	scrollbar.anchors.right = ['parent', 'right']
		# 	scrollbar.margin = 3
		# 	scrollbar.z = 1
		# 	scrollbar.pointer.onPressed ->
		# 		unless scrollbar.$.pressed
		# 			scrollbar.$.pressed = true
		# 			scrollbar.pointer.onMoved.connect scrollbar.$.pointerMoveHandler
		# 			scrollbar.pointer.onReleased.connect scrollbar.$.pointerReleasedHandler
		# 		signal.STOP_PROPAGATION
		# 	scrollbar.$.pointerReleasedHandler = ->
		# 		scrollbar.$.pressed = false
		# 		scrollbar.pointer.onMoved.disconnect scrollbar.$.pointerMoveHandler
		# 		scrollbar.pointer.onReleased.disconnect scrollbar.$.pointerReleasedHandler
		# 		return
		# 	scrollbar.$.pointerMoveHandler = (e) ->
		# 		unless scrollbar.$.pressed
		# 			return
		# 		delta = e.movementY / (scrollbar.parent.height / scrollbar.parent.contentItem.height)
		# 		contentY = scrollbar.parent.contentY + delta
		# 		contentY = Math.max 0, Math.min contentY, (scrollbar.parent.contentItem.height - scrollbar.parent.height)
		# 		scrollbar.parent.contentY = contentY
		# 		return

		# 	thumb = new Renderer.Rectangle
		# 	thumb.parent = scrollbar
		# 	thumb.createBinding 'y', [
		# 		[[['this', 'parent'], 'margin'], 'top']
		# 	]
		# 	thumb.createBinding 'width', [
		# 		[['this', 'parent'], 'width']
		# 	]
		# 	thumb.createBinding 'height', [
		# 		[['this', 'parent'], 'height'],
		# 		'-',
		# 		[[['this', 'parent'], 'margin'], 'top'],
		# 		'-',
		# 		[[['this', 'parent'], 'margin'], 'bottom']
		# 	]
		# 	thumb.color = 'rgba(0, 0, 0, .5)'
		# 	thumb.createBinding 'radius', [
		# 		['this', 'width'],
		# 		'/2'
		# 	]
		# 	thumb.border.width = 1
		# 	thumb.border.color = 'rgba(200, 200, 200, 0.5)'

		# 	state = new Renderer.State
		# 	state.target = thumb
		# 	state.createBinding 'when', [[[thumb, 'pointer'], 'isHover'], '||', [scrollbar.$, 'pressed']]
		# 	state.changes.color = 'black'

		# 	scrollbar.ready()
		# 	thumb.ready()
		# 	state.ready()

		# 	scrollbar

*Scrollable* Scrollable.New(*Component* component, [*Object* options])
----------------------------------------------------------------------

		@New = (component, opts) ->
			item = new Scrollable
			itemUtils.Object.initialize item, component, opts
			item.clip = true
			item

*Scrollable* Scrollable() : *Renderer.Item*
-------------------------------------------

		constructor: ->
			super()
			@_contentItem = null
			@_contentX = 0
			@_contentY = 0
			@_snap = false
			@_snapItem = null

*Boolean* Scrollable::clip = true
---------------------------------

*Renderer.Item* Scrollable::contentItem = null
----------------------------------------------

### *Signal* Scrollable::onContentItemChange([*Renderer.Item* oldValue])

		itemUtils.defineProperty
			constructor: @
			name: 'contentItem'
			defaultValue: null
			implementation: Impl.setScrollableContentItem
			setter: (_super) -> (val) ->
				@_contentItem?.parent = null
				if val?
					assert.instanceOf val, Renderer.Item
					val.parent = @
					val.index = 0
				_super.call @, val

*Float* Scrollable::contentX = 0
--------------------------------

### *Signal* Scrollable::onContentXChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'contentX'
			defaultValue: 0
			implementation: Impl.setScrollableContentX
			developmentSetter: (val) ->
				assert.isFloat val
			setter: (_super) -> (val) ->
				@_contentItem?._x = -val
				_super.call @, val

*Float* Scrollable::contentY = 0
--------------------------------

### *Signal* Scrollable::onContentYChange(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'contentY'
			defaultValue: 0
			implementation: Impl.setScrollableContentY
			developmentSetter: (val) ->
				assert.isFloat val
			setter: (_super) -> (val) ->
				@_contentItem?._y = -val
				_super.call @, val

*Boolean* Scrollable::snap = false
----------------------------------

### *Signal* Scrollable::onSnapChange(*Boolean* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'snap'
			defaultValue: false
			implementation: Impl.setScrollableSnap
			developmentSetter: (val) ->
				assert.isBoolean val

*Renderer.Item* Scrollable::snapItem
------------------------------------

### *Signal* Scrollable::onSnapItemChange(*Renderer.Item* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'snapItem'
			defaultValue: null
			implementation: Impl.setScrollableSnapItem
			developmentSetter: (val=null) ->
				if val?
					assert.instanceOf val, Renderer.Item
