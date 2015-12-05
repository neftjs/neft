'use strict'

utils = require 'utils'
PIXI = require '../pixi.lib.js'

module.exports = (impl) ->
	{round} = Math
	{pixelRatio} = impl

	cssUtils = require '../../css/utils'

	updateTextStyle = (item) ->
		data = item._impl
		{textStyle} = data
		textStyle.font = "#{textStyle.pixelSize}px #{textStyle.fontFamily}"
		data.textElem.style = textStyle
		return

	updateSize = do ->
		pending = false
		queue = []

		update = (item) ->
			{textElem} = item._impl
			textElem.updateText()
			item.contentWidth = textElem.canvas.width / textElem.resolution
			item.contentHeight = textElem.canvas.height / textElem.resolution
			updateAlignment item
			return

		updateAll = (item) ->
			while item = queue.pop()
				item._impl.sizeUpdatePending = false
				update item
			pending = false
			return

		(item) ->
			if item._impl.sizeUpdatePending
				return

			item._impl.sizeUpdatePending = true
			queue.push item

			unless pending
				setImmediate updateAll
				pending = true
			return

	updateAlignment = (item) ->
		{textElem, textElemData} = item._impl
		if alignment = item._alignment
			textElemData.x = item.width - textElem.canvas.width / textElem.resolution
			switch alignment.horizontal
				when 'left'
					textElemData.x = 0
				when 'center'
					textElemData.x *= 0.5

			textElemData.y = item.height - textElem.canvas.height / textElem.resolution
			switch alignment.vertical
				when 'top'
					textElemData.y = 0
				when 'center'
					textElemData.y *= 0.5
			impl._dirty = true
		return

	onFontLoaded = (font) ->
		if font is @_impl.textStyle.fontFamily
			updateSize @
			impl._dirty = true
		return

	onWidthChange = ->
		@_impl.textStyle.wordWrapWidth = @_width
		if not @_autoWidth and @_alignment and @_alignment.horizontal isnt 'left'
			updateSize @
		updateAlignment @
		return

	onHeightChange = ->
		updateAlignment @
		return

	DATA =
		sizeUpdatePending: false
		autoWidth: true
		autoHeight: true
		textStyle:
			pixelSize: 13
			fontFamily: 'sans-serif'
			font: '13px sans-serif'
			fill: 'black'
			align: 'left'
			wordWrap: false
			wordWrapWidth: 100
		textElemData:
			width: 0
			height: 0
			x: 0
			y: 0
			scale: 1
		textElem: null

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		data.textElem = new PIXI.Text ' ', data.textStyle
		data.textElem._data = data.textElemData
		# BUG in pixi.js: width and height getters updates text, but resolution is set
		# while rendering only if text is dirty
		data.textElem.resolution = pixelRatio
		data.elem.addChild data.textElem

		# reload on font loaded
		unless impl.utils.loadedFonts[data.textStyle.fontFamily]
			impl.utils.onFontLoaded onFontLoaded, @

		# update autoWidth/autoHeight
		@onWidthChange onWidthChange
		@onHeightChange onHeightChange
		return

	setText: (val) ->
		val = val.replace ///<[bB][rR]\s?\/?>///g, "\n"

		# remove html tags
		# TODO: add simple html support
		val = val.replace ///<([^>]+)>///g, ""

		@_impl.textElem.text = val
		updateSize @
		return

	setTextWrap: (val) ->
		@_impl.textStyle.wordWrap = val
		@_impl.textStyle.wordWrapWidth = @_width
		updateSize @
		return

	updateTextContentSize: ->
		updateSize @
		return

	setTextColor: (val) ->
		@_impl.textStyle.fill = val
		updateTextStyle @
		return

	setTextLinkColor: (val) ->

	setTextLineHeight: (val) ->
		# @_impl.textStyle.lineHeight = val * @font.pixelSize
		# updateSize @
		return

	setTextFontFamily: (val) ->
		unless impl.utils.loadedFonts[val]
			impl.utils.onFontLoaded onFontLoaded, @

		@_impl.textStyle.fontFamily = val
		updateTextStyle @
		updateSize @
		return

	setTextFontPixelSize: (val) ->
		{textStyle} = @_impl
		textStyle.pixelSize = val
		# textStyle.lineHeight = @lineHeight * val
		updateTextStyle @
		updateSize @
		return

	setTextFontWordSpacing: (val) ->

	setTextFontLetterSpacing: (val) ->

	setTextAlignmentHorizontal: (val) ->
		@_impl.textStyle.align = val
		return

	setTextAlignmentVertical: (val) ->
