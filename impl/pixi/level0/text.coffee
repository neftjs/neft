'use strict'

utils = require 'utils'
PIXI = require '../pixi.lib.js'

module.exports = (impl) ->
	updatePending = false

	updateSize = ->
		data = @_impl
		{textElem} = data

		updatePending = true

		if data.autoWidth
			@width = textElem.width

		if data.autoHeight
			@height = textElem.height

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
		@_impl.textStyle.font = "#{@_impl.textStyle.pixelSize}px #{@_impl.textStyle.fontFamily}"
		@_impl.textElem.setStyle @_impl.textStyle
		return

	DATA =
		autoWidth: true
		autoHeight: true
		textStyle:
			pixelSize: 13
			fontFamily: 'Arial'
			font: '13px Arial'
			fill: 'black'
			align: 'left'
			wordWrap: false
			wordWrapWidth: 100
		textElem: null

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		impl.Types.Item.create.call @, data

		data.textElem = new PIXI.Text 'abc', data.textStyle
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

	setTextLinkColor: (val) ->

	setTextLineHeight: (val) ->

	setTextFontFamily: (val) ->
		@_impl.textStyle.fontFamily = val
		updateTextStyle.call @

	setTextFontPixelSize: (val) ->
		@_impl.textStyle.pixelSize = val or 1
		updateTextStyle.call @

	setTextFontWeight: (val) ->

	setTextFontWordSpacing: (val) ->

	setTextFontLetterSpacing: (val) ->

	setTextAlignmentHorizontal: (val) ->
		@_impl.textStyle.align = val
		updateTextStyle.call @

	setTextAlignmentVertical: (val) ->
