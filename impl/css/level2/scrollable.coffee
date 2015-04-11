'use strict'

utils = require 'utils'
signal = require 'signal'

isTouch = 'ontouchstart' of window
isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{Types} = impl
	{Item, Rectangle} = Types

	{round} = Math

	abstractScrollable = impl.AbstractTypes.Scrollable impl

	# transform looks faster, so let's use it on mobile,
	# where search and scrollbars are not using
	if isTouch
		return abstractScrollable
	else
		impl._scrollableUsePointer = false

	DATA =
		contentItem: null
		scrollElem: null
		globalScale: 1
		snap: false
		lastSnapTargetX: 0
		lastSnapTargetY: 0
		yScrollbar: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		self = @

		abstractScrollable.create.call @, data

		scrollElem = data.scrollElem = document.createElement 'div'
		scrollElem.style.overflow = 'hidden'
		scrollElem.style.width = '100%'
		scrollElem.style.height = '100%'
		data.elem.appendChild scrollElem

		# searching etc.
		scrollElem.addEventListener 'scroll', ->
			if round(@scrollLeft) isnt round(self._contentX)
				self.contentX = @scrollLeft
			if round(@scrollTop) isnt round(self._contentY)
				self.contentY = @scrollTop
			return

		return

	setScrollableContentItem: do ->
		onHeightChanged = ->
			data = @_impl
			contentItem = @_contentItem
			if contentItem._height <= @_height
				if data.yScrollbar
					data.scrollElem.style.overflowY = 'hidden'
					data.yScrollbar = false
			else
				if not data.yScrollbar
					data.scrollElem.style.overflowY = 'scroll'
					data.yScrollbar = true
			return

		(val) ->
			if oldVal = @_impl.contentItem
				impl.setItemParent.call oldVal, null
				oldVal.onHeightChanged.disconnect onHeightChanged, @

			if val
				@_impl.scrollElem.appendChild val._impl.elem
				val.onHeightChanged onHeightChanged, @
				@_impl.contentItem = val
			return

	setScrollableContentX: (val) ->
		@_impl.scrollElem.scrollLeft = round val
		return

	setScrollableContentY: (val) ->
		@_impl.scrollElem.scrollTop = round val
		return
