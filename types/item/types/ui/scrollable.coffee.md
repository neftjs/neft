Renderer.Scrollable
===================

	'use strict'

	expect = require 'expect'
	utils = require 'utils'
	signal = require 'signal'

*Scrollable* Scrollable([*Object* options, *Array* children]) : *Renderer.Item*
-------------------------------------------------------------------------------

	module.exports = (Renderer, Impl, itemUtils) -> class Scrollable extends Renderer.Item
		@__name__ = 'Scrollable'
		@__path__ = 'Renderer.Scrollable'

		itemUtils.initConstructor @,
			extends: Renderer.Item
			data:
				contentX: 0
				contentY: 0
				contentItem: null
				verticalScrollbar: null
				clip: true

		@createDefaultVerticalScrollbar = ->
			scrollbar = new Renderer.Item
				properties: ['pressed', 'pointerMoveHandler', 'pointerReleasedHandler']
				pressed: false
				width: 8
				height: {binding: [
					[['this', 'parent'], 'height'],
					'/',
					[[['this', 'parent'], 'contentItem'], 'height'],
					'*',
					[['this', 'parent'], 'height']
				]}
				anchors:
					right: ['parent', 'right']
				margin: 3
				onPointerPressed: ->
					unless @pressed
						@pressed = true
						@parent.onPointerMove.connect @pointerMoveHandler
						@parent.onPointerReleased.connect @pointerReleasedHandler
				pointerReleasedHandler: ->
					scrollbar.pressed = false
					scrollbar.lastEvent = null
					scrollbar.parent.onPointerMove.disconnect scrollbar.pointerMoveHandler
					scrollbar.parent.onPointerReleased.disconnect scrollbar.pointerReleasedHandler
				pointerMoveHandler: (e) ->
					unless scrollbar.pressed
						return
					if scrollbar.lastEvent
						delta = (e.y - scrollbar.lastEvent.y) / (scrollbar.parent.height / scrollbar.parent.contentItem.height)
						contentY = scrollbar.parent.contentY + delta
						contentY = Math.max 0, Math.min contentY, (scrollbar.parent.contentItem.height - scrollbar.parent.height)
						scrollbar.parent.contentY = contentY
					scrollbar.lastEvent = e
					signal.STOP_PROPAGATION
			, [
				new Renderer.Rectangle
					y: {binding: [
						[[['this', 'parent'], 'margin'], 'top']
					]}
					width: {binding: [
						[['this', 'parent'], 'width']
					]}
					height: {binding: [
						[['this', 'parent'], 'height'],
						'-',
						[[['this', 'parent'], 'margin'], 'top'],
						'-',
						[[['this', 'parent'], 'margin'], 'bottom']
					]}
					state: {binding: [
						[['this', 'parent'], 'state']
					]}
					color: 'rgba(0, 0, 0, .5)'
					radius: {binding: [
						['this', 'width'],
						'/2'
					]}
					border:
						width: 1
						color: 'rgba(0, 0, 0, .2)'
					onPointerEntered: ->
						@state = 'hover'
					onPointerExited: ->
						@state = ''
					states:
						hover: new Renderer.State
							color: 'rgba(0, 0, 0, .8)'
			]

		constructor: ->
			super

			@onReady ->
				{contentItem} = @
				expect().some(@children).toBe contentItem

				unless @_data.hasOwnProperty 'verticalScrollbar'
					@verticalScrollbar = Scrollable.createDefaultVerticalScrollbar()

			@onContentYChanged ->
				{verticalScrollbar} = @
				if verticalScrollbar
					verticalScrollbar.y = @contentY * @height / @contentItem.height

*Renderer.Item* Scrollable::contentItem
---------------------------------------

### *Signal* Scrollable::contentItemChanged([*Renderer.Item* oldValue])

		itemUtils.defineProperty
			constructor: @
			name: 'contentItem'
			implementation: Impl.setScrollableContentItem
			setter: (_super) -> (val) ->
				expect(val).toBe.any Renderer.Item
				oldVal = @contentItem
				val.parent = @
				_super.call @, val
				oldVal?.parent = null

*Renderer.Item* Scrollable::verticalScrollbar
---------------------------------------------

### *Signal* Scrollable::verticalScrollbarChanged([*Renderer.Item* oldValue])

		itemUtils.defineProperty
			constructor: @
			name: 'verticalScrollbar'
			setter: (_super) -> (val) ->
				oldVal = @verticalScrollbar
				if val?
					expect(val).toBe.any Renderer.Item
					val.parent = @
				_super.call @, val
				oldVal?.parent = null

*Float* Scrollable::contentX
----------------------------

### *Signal* Scrollable::contentXChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'contentX'
			implementation: Impl.setScrollableContentX
			developmentSetter: (val) ->
				expect(val).toBe.float()

*Float* Scrollable::contentY
----------------------------

### *Signal* Scrollable::contentYChanged(*Float* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'contentY'
			implementation: Impl.setScrollableContentY
			developmentSetter: (val) ->
				expect(val).toBe.float()
