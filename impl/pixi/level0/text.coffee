'use strict'

utils = require 'utils'
PIXI = require '../pixi.lib.js'

module.exports = (impl) ->
	{round} = Math
	{pixelRatio} = impl

	cssUtils = require '../../css/utils'

	updatePending = false

	updateSize = ->
		data = @_impl
		{textElem} = data

		updatePending = true

		if data.autoWidth
			@width = round textElem.width / pixelRatio

		if data.autoHeight
			@height = round textElem.height / pixelRatio

		updatePending = false
		return

	onWidthChanged = ->
		if not updatePending
			auto = @_impl.autoWidth = @width is 0
			@_impl.textStyle.wordWrap = not auto
			@_impl.textStyle.wordWrapWidth = @width
			updateTextStyle.call @
			if @_impl.autoWidth or @_impl.autoHeight
				updateSize.call @
		return

	onHeightChanged = ->
		if not updatePending
			@_impl.autoHeight = @height is 0
			if @_impl.autoWidth or @_impl.autoHeight
				updateSize.call @
		return

	updateTextStyle = ->
		data = @_impl
		{textStyle} = data
		textStyle.font = "#{textStyle.style} #{textStyle.weight} #{textStyle.pixelSize}px #{textStyle.fontFamily}"
		data.textElem.setStyle textStyle
		return

	DATA =
		autoWidth: true
		autoHeight: true
		textStyle:
			pixelSize: 13
			fontFamily: 'Arial'
			style: 'normal'
			font: '13px Arial'
			fill: 'black'
			align: 'left'
			weight: 400
			wordWrap: false
			wordWrapWidth: 100
		textElem: null

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		data.textElem = new PIXI.Text ' ', data.textStyle
		# BUG in pixi.js: width and height getters updates text, but resolution is set
		# while rendering only if text is dirty
		data.textElem.resolution = pixelRatio
		data.elem.addChild data.textElem

		# update autoWidth/autoHeight
		@onWidthChanged onWidthChanged
		@onHeightChanged onHeightChanged
		return

	setText: (val) ->
		val = val.replace ///<br>///g, "\n"

		@_impl.textElem.setText val
		updateSize.call @
		return

	setTextColor: (val) ->
		@_impl.textStyle.fill = val
		updateTextStyle.call @
		return

	setTextLinkColor: (val) ->

	setTextLineHeight: (val) ->

	setTextFontFamily: (val) ->
		@_impl.textStyle.fontFamily = val
		updateTextStyle.call @
		updateSize.call @
		return

	setTextFontPixelSize: (val) ->
		@_impl.textStyle.pixelSize = round val or 1
		updateTextStyle.call @
		updateSize.call @
		return

	setTextFontWeight: (val) ->
		@_impl.textStyle.weight = cssUtils.getFontWeight(val)
		updateTextStyle.call @
		return

	setTextFontWordSpacing: (val) ->

	setTextFontLetterSpacing: (val) ->

	setTextFontItalic: (val) ->
		@_impl.textStyle.style = if val then 'italic' else 'normal'
		updateTextStyle.call @
		return

	setTextAlignmentHorizontal: (val) ->
		@_impl.textStyle.align = val
		updateTextStyle.call @
		return

	setTextAlignmentVertical: (val) ->
