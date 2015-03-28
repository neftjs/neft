'use strict'

utils = require 'utils'
signal = require 'signal'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

module.exports = (impl) ->
	{Types} = impl
	{Item, Rectangle} = Types

	{round} = Math

	impl._scrollableUsePointer = false
	impl._scrollableUseWheel = false
	abstractScrollable = impl.AbstractTypes.Scrollable impl

	DATA =
		contentItem: null
		scrollElem: null
		globalScale: 1
		snap: false
		lastSnapTargetX: 0
		lastSnapTargetY: 0
		scrollX: false
		scrollY: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		self = @

		abstractScrollable.create.call @, data

		scrollElem = data.scrollElem = document.createElement 'div'
		scrollElem.style.overflow = 'hidden'
		scrollElem.style.width = '100%'
		scrollElem.style.height = '100%'
		scrollElem.style.backgroundImage = 'url(\'\')' # Chrome bug, doesn't scroll on empty
		data.elem.appendChild scrollElem

		scrollElem.addEventListener 'scroll', ->
			if round(@scrollLeft) isnt self.contentX
				self.contentX = @scrollLeft
			if round(@scrollTop) isnt self.contentY
				self.contentY = @scrollTop
			return

		# slow mouse scrolling on firefox
		if isFirefox
			scrollElem.addEventListener 'wheel', (e) ->
				if e.deltaMode is e.DOM_DELTA_LINE
					self.contentX += e.deltaX * 10
					self.contentY += e.deltaY * 10
				return

		return

	setScrollableContentItem: do ->
		# onWidthChanged = ->
		# 	if @_width < @_contentItem._width and not @_impl.scrollX
		# 		@_impl.scrollElem.style.overflowX = 'scroll'
		# 		@_impl.scrollX = true
		# 	else if @_width >= @_contentItem._width and @_impl.scrollX
		# 		@_impl.scrollElem.style.overflowX = 'hidden'
		# 		@_impl.scrollX = false
		# 	return

		onHeightChanged = ->
			if @_height < @_contentItem._height and not @_impl.scrollY
				@_impl.scrollElem.style.overflowY = 'scroll'
				@_impl.scrollY = true
			else if @_height >= @_contentItem._height and @_impl.scrollY
				@_impl.scrollElem.style.overflowY = 'hidden'
				@_impl.scrollY = false
			return

		(val) ->
			if oldVal = @_impl.contentItem
				impl.setItemParent.call oldVal, null
				# oldVal.onWidthChanged.disconnect onWidthChanged, @
				oldVal.onHeightChanged.disconnect onHeightChanged, @

			if val
				@_impl.scrollElem.appendChild val._impl.elem
				# val.onWidthChanged onWidthChanged, @
				val.onHeightChanged onHeightChanged, @
				@_impl.contentItem = val
			return

	setScrollableContentX: (val) ->
		@_impl.scrollElem.scrollLeft = round val
		return

	setScrollableContentY: (val) ->
		@_impl.scrollElem.scrollTop = round val
		return
