'use strict'

utils = require 'utils'
signal = require 'signal'

module.exports = (impl) ->
	{Types} = impl
	{Item, Rectangle} = Types

	{round} = Math

	abstractScrollable = impl.AbstractTypes.Scrollable impl

	DATA =
		contentItem: null
		scrollElem: null
		globalScale: 1
		snap: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		abstractScrollable.create.call @, data

		scrollElem = data.scrollElem = document.createElement 'div'
		scrollElem.style.overflow = 'scroll'
		scrollElem.style.width = '110%'
		scrollElem.style.height = '110%'
		data.elem.appendChild scrollElem

		scrollElem.addEventListener 'touchstart', (e) ->
			if e.target.tagName isnt 'A'
				e.preventDefault()

		return

	setScrollableContentItem: do ->
		onWidthChanged = ->
			impl.setItemWidth.call @, @_width * 1.1
			return

		onHeightChanged = ->
			impl.setItemHeight.call @, @_height * 1.1
			return

		(val) ->
			if oldVal = @_impl.contentItem
				impl.setItemParent.call oldVal, null
				oldVal.onWidthChanged.disconnect onWidthChanged
				oldVal.onHeightChanged.disconnect onHeightChanged

			if val
				@_impl.scrollElem.appendChild val._impl.elem
				val.onWidthChanged onWidthChanged
				val.onHeightChanged onHeightChanged
				@_impl.contentItem = val
			return

	setScrollableContentX: (val) ->
		@_impl.scrollElem.scrollLeft = round val
		return

	setScrollableContentY: (val) ->
		@_impl.scrollElem.scrollTop = round val
		return
