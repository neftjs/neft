'use strict'

module.exports = (impl) ->
	DATA =
		contentItem: null
		scrollElem: null
		yScrollbar: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		self = @

		impl.Types.Item.create.call @, data

		scrollElem = data.scrollElem = document.createElement 'div'
		scrollElem.style.overflow = 'hidden'
		scrollElem.style.width = '100%'
		scrollElem.style.height = '100%'
		data.elem.appendChild scrollElem

		@onParentChange ->
			scrollElem.scrollLeft = self._contentX
			scrollElem.scrollTop = self._contentY
			return

		setContentX = (val) ->
			max = self._impl.contentItem?._width - self._width or 0
			if val < 0
				val = 0
			if val > max
				val = max

			oldVal = self.contentX
			if val isnt oldVal
				self._contentX = val
				self.onContentXChange.emit oldVal

		setContentY = (val) ->
			max = self._impl.contentItem?._height - self._height or 0
			if val > max
				val = max
			if val < 0
				val = 0

			oldVal = self.contentY
			if val isnt oldVal
				self._contentY = val
				self.onContentYChange.emit oldVal

		syncScroll = ->
			setContentX @scrollLeft
			setContentY @scrollTop
			return

		# safari scroll event throttling fix
		scrollElem.addEventListener impl.utils.pointerWheelEventName, (e) ->
			if e.deltaX?
				setContentX @scrollLeft + e.deltaX
				setContentY @scrollTop + e.deltaY

		scrollElem.addEventListener 'scroll', syncScroll
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
				if oldVal._impl.elem.parentElement is @_impl.scrollElem
					@_impl.scrollElem.removeChild oldVal._impl.elem
				oldVal.onHeightChange.disconnect onHeightChange, @

			if val
				val.onHeightChange onHeightChange, @
				@_impl.contentItem = val
				@_impl.scrollElem.appendChild val._impl.elem
			return

	setScrollableContentX: (val) ->
		@_impl.scrollElem.scrollLeft = val
		return

	setScrollableContentY: (val) ->
		@_impl.scrollElem.scrollTop = val
		return

	setScrollableSnap: (val) ->
		return

	setScrollableSnapItem: (val) ->
		return
