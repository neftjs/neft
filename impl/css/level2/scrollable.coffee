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
		updateScroll: null

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

		data.updateScroll = ->
			self._impl.scrollElem.scrollLeft = round self._contentX
			self._impl.scrollElem.scrollTop = round self._contentY
			return

		# creating
		@onParentChange data.updateScroll

		# searching etc.
		scrollElem.addEventListener 'scroll', (e) ->
			x = abstractScrollable._getLimitedX self, @scrollLeft
			y = abstractScrollable._getLimitedY self, @scrollTop
			if round(x) isnt round(self._contentX)
				self.contentX = x
			if round(y) isnt round(self._contentY)
				self.contentY = y
			return

		return

	setScrollableContentItem: do ->
		onHeightChange = ->
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
				oldVal.onHeightChange.disconnect onHeightChange, @

			if val
				val.onHeightChange onHeightChange, @
				@_impl.contentItem = val
				@_impl.scrollElem.appendChild val._impl.elem
			return

	setScrollableContentX: (val) ->
		@_impl.scrollElem.scrollLeft = round val
		if val > 0 and @_impl.scrollElem.scrollLeft is 0
			setTimeout @_impl.updateScroll
		return

	setScrollableContentY: (val) ->
		@_impl.scrollElem.scrollTop = round val
		if val > 0 and @_impl.scrollElem.scrollTop is 0
			setTimeout @_impl.updateScroll
		return
