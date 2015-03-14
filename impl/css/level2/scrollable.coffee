'use strict'

utils = require 'utils'
signal = require 'signal'

module.exports = (impl) ->
	{Types} = impl
	{Item, Rectangle} = Types

	abstractScrollable = impl.AbstractTypes.Scrollable impl

	DATA =
		contentItem: null
		scrollElem: null
		globalScale: 1
		contentX: 0
		contentY: 0

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

	setScrollableContentItem: (val) ->
		if oldVal = @_impl.contentItem
			impl.setItemParent.call oldVal, null

		if val
			@_impl.scrollElem.appendChild val._impl.elem
			@_impl.contentItem = val

	setScrollableContentX: (val) ->
		@_impl.contentX = val
		impl.updateStyles @, impl.STYLE_SCROLL
		return

	setScrollableContentY: (val) ->
		@_impl.contentY = val
		impl.updateStyles @, impl.STYLE_SCROLL
		return
