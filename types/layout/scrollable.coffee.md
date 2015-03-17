Positioning/Scrollable
======================

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	signal = require 'signal'

*Scrollable* Scrollable() : *Renderer.Item*
-------------------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class Scrollable extends Renderer.Item
		@__name__ = 'Scrollable'
		@__path__ = 'Renderer.Scrollable'

		@createDefaultVerticalScrollbar = ->
			scrollbar = new Renderer.Item
			scrollbar.createProperty 'lastEvent'
			scrollbar.createProperty 'pressed'
			scrollbar.createProperty 'pointerMoveHandler'
			scrollbar.createProperty 'pointerReleasedHandler'
			scrollbar.$.pressed = false
			scrollbar.width = 8
			scrollbar.createBinding 'height', [
				[['this', 'parent'], 'height'],
				'/',
				[[['this', 'parent'], 'contentItem'], 'height'],
				'*',
				[['this', 'parent'], 'height']
			]
			scrollbar.anchors.right = ['parent', 'right']
			scrollbar.margin = 3
			scrollbar.z = 1
			scrollbar.pointer.onPressed ->
				unless @$.pressed
					@$.pressed = true
					@parent.pointer.onMoved.connect @$.pointerMoveHandler
					@parent.pointer.onReleased.connect @$.pointerReleasedHandler
				signal.STOP_PROPAGATION
			scrollbar.$.pointerReleasedHandler = ->
				scrollbar.$.pressed = false
				scrollbar.$.lastEvent = null
				scrollbar.parent.pointer.onMoved.disconnect scrollbar.$.pointerMoveHandler
				scrollbar.parent.pointer.onReleased.disconnect scrollbar.$.pointerReleasedHandler
				return
			scrollbar.$.pointerMoveHandler = (e) ->
				unless scrollbar.$.pressed
					return
				if scrollbar.$.lastEvent
					delta = (e.y - scrollbar.$.lastEvent.y) / (scrollbar.parent.height / scrollbar.parent.contentItem.height)
					contentY = scrollbar.parent.contentY + delta
					contentY = Math.max 0, Math.min contentY, (scrollbar.parent.contentItem.height - scrollbar.parent.height)
					scrollbar.parent.contentY = contentY
				scrollbar.$.lastEvent = e
				return

			thumb = new Renderer.Rectangle
			thumb.parent = scrollbar
			thumb.createBinding 'y', [
				[[['this', 'parent'], 'margin'], 'top']
			]
			thumb.createBinding 'width', [
				[['this', 'parent'], 'width']
			]
			thumb.createBinding 'height', [
				[['this', 'parent'], 'height'],
				'-',
				[[['this', 'parent'], 'margin'], 'top'],
				'-',
				[[['this', 'parent'], 'margin'], 'bottom']
			]
			thumb.color = 'rgba(0, 0, 0, .5)'
			thumb.createBinding 'radius', [
				['this', 'width'],
				'/2'
			]
			thumb.border.width = 1
			thumb.border.color = 'rgba(0, 0, 0, .2)'

			state = new Renderer.State
			state.target = thumb
			state.createBinding 'when', [[[thumb, 'pointer'], 'isHover'], '||', [scrollbar, 'pressed']]
			state.changes.color = 'rgba(0, 0, 0, .8)'
			
			scrollbar

		constructor: ->
			@_contentItem = null
			@_verticalScrollbar = null
			@_autoVerticalScrollbar = true
			@_contentX = 0
			@_contentY = 0
			super()
			@clip = true

			@onReady ->
				{contentItem} = @
				if @_autoVerticalScrollbar
					@verticalScrollbar = Scrollable.createDefaultVerticalScrollbar()

			@onContentYChanged ->
				{verticalScrollbar} = @
				if verticalScrollbar
					verticalScrollbar.y = @contentY * @height / @contentItem.height

*Boolean* Scrollable::clip = true
---------------------------------

*Renderer.Item* Scrollable::contentItem = null
----------------------------------------------

### *Signal* Scrollable::contentItemChanged([*Renderer.Item* oldValue])

		itemUtils.defineProperty
			constructor: @
			name: 'contentItem'
			defaultValue: null
			implementation: Impl.setScrollableContentItem
			setter: (_super) -> (val) ->
				@_contentItem?._parent = null
				if val?
					expect(val).toBe.any Renderer.Item
					val._parent = @
				_super.call @, val

*Renderer.Item* Scrollable::verticalScrollbar
---------------------------------------------

### *Signal* Scrollable::verticalScrollbarChanged([*Renderer.Item* oldValue])

		itemUtils.defineProperty
			constructor: @
			name: 'verticalScrollbar'
			defaultValue: null
			setter: (_super) -> (val) ->
				oldVal = @verticalScrollbar
				if val?
					expect(val).toBe.any Renderer.Item
					val.parent = @
				_super.call @, val
				oldVal?.parent = null
				@_autoVerticalScrollbar = false

*Float* Scrollable::contentX = 0
--------------------------------

### *Signal* Scrollable::contentXChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'contentX'
			defaultValue: 0
			implementation: Impl.setScrollableContentX
			developmentSetter: (val) ->
				expect(val).toBe.float()

*Float* Scrollable::contentY = 0
--------------------------------

### *Signal* Scrollable::contentYChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'contentY'
			defaultValue: 0
			implementation: Impl.setScrollableContentY
			developmentSetter: (val) ->
				expect(val).toBe.float()

		clone: ->
			clone = super()
			clone
