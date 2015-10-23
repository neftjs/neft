'use strict'

signal = require 'signal'

module.exports = (impl) ->
	implUtils = impl.utils
	{round} = Math

	SHEET = """
		textarea, input[type=password] {
			width: 100%;
			height: 100%;
			resize: none;
			background: none;
			border: none;
			box-sizing: border-box;
			font-size: 14px;
			line-height: 1;
			font-family: #{impl.utils.DEFAULT_FONTS['sans-serif']}, sans-serif;
		}
		input[type=password] {
			padding-top: 0 !important;
		}
	"""

	window.addEventListener 'load', ->
		styles = document.createElement 'style'
		styles.innerHTML = SHEET
		document.body.appendChild styles

	reloadFontFamily = (family) ->
		if (@_font and @_font._family is family) or (not @_font and family is 'sans-serif')
			@_impl.innerElemStyle.fontFamily = @_impl.innerElemStyle.fontFamily
		return

	updateVerticalAlignment = (textInput) ->
		data = @_impl
		{verticalAlignment} = data
		if verticalAlignment is 'top'
			padding = 0
		else
			lineHeightPx = @_lineHeight * (@_font?._pixelSize or 14)
			linesLength = (data.innerElem.value.match(/\n/g)?.length or 0) + 1
			freeSpace = Math.max 0, @_height - linesLength * lineHeightPx
			if verticalAlignment is 'center'
				padding = freeSpace / 2
			else
				padding = freeSpace
		data.innerElemStyle.paddingTop = "#{padding}px"

	COLOR_RESOURCE_REQUEST =
		property: 'color'

	DATA =
		isMultiLine: false
		textareaElem: null
		innerElem: null
		innerElemStyle: null
		verticalAlignment: 'top'

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		self = @

		impl.Types.Item.create.call @, data

		# innerElem
		innerElem = data.innerElem = data.textareaElem = document.createElement 'textarea'
		data.innerElemStyle = innerElem.style
		data.innerElemStyle.whiteSpace = 'nowrap'
		data.elem.appendChild innerElem

		# prevent scrollable on input
		data.elem.addEventListener impl._SIGNALS.pointerOnWheel, (e) ->
			if data.isMultiLine and document.activeElement is innerElem
				e.stopPropagation()
			return

		# prevent multi lines
		data.elem.addEventListener 'keydown', (e) ->
			if not data.isMultiLine and (window.event?.keyCode or e.which) is 13
				e.preventDefault()

		# manage focus
		innerElem.addEventListener 'focus', ->
			self.keys.focus = true
		innerElem.addEventListener 'blur', ->
			self.keys.focus = false
		@keys.onFocusChange (oldVal) ->
			data.innerElem[if !oldVal then 'focus' else 'blur']()

		# update text
		innerElem.addEventListener 'input', ->
			{value} = innerElem
			# prevent copying new lines
			if not data.isMultiLine and /\n/.test(value)
				value = value.replace /\n/g, ''
			self.text = value

		# set default size
		impl.setItemWidth.call @, 100
		impl.setItemHeight.call @, 50

		# reload font on load
		if impl.utils.loadingFonts['sans-serif'] > 0
			impl.utils.onFontLoaded reloadFontFamily, @

		# vertical alignment
		@onHeightChange updateVerticalAlignment

	setTextInputText: (val) ->
		if @_impl.innerElem.value isnt val
			@_impl.innerElem.value = val
		updateVerticalAlignment.call @
		return

	setTextInputColor: (val) ->
		val = impl.Renderer.resources?.resolve(val, COLOR_RESOURCE_REQUEST) or val
		@_impl.innerElemStyle.color = val
		return

	setTextInputLineHeight: (val) ->
		@_impl.innerElemStyle.lineHeight = val
		return

	setTextInputMultiLine: (val) ->
		data = @_impl
		data.isMultiLine = val
		data.innerElemStyle.whiteSpace = 'nowrap'
		unless val
			@text = @text.replace /\n/g, ''
		return

	setTextInputEchoMode: (val) ->
		self = @
		data = @_impl
		switch val
			when 'normal'
				data.elem.removeChild data.innerElem
				implUtils.prependElement data.elem, data.textareaElem
				data.textareaElem.setAttribute 'style', data.innerElem.getAttribute('style')
				data.innerElem = data.textareaElem
				data.innerElemStyle = data.textareaElem.style
			when 'password'
				input = document.createElement 'input'
				input.setAttribute 'type', 'password'
				input.setAttribute 'style', data.innerElem.getAttribute('style')
				data.elem.removeChild data.innerElem
				implUtils.prependElement data.elem, input
				data.innerElem = input
				data.innerElemStyle = input.style
				input.addEventListener 'input', ->
					self.text = input.value
					return
		return

	setTextInputFontFamily: (val) ->
		if impl.utils.loadingFonts[val] > 0
			impl.utils.onFontLoaded reloadFontFamily, @

		if impl.utils.DEFAULT_FONTS[val]
			val = "#{impl.utils.DEFAULT_FONTS[val]}, #{val}"
		else
			val = "'#{val}'"
		@_impl.innerElemStyle.fontFamily = val
		return

	setTextInputFontPixelSize: (val) ->
		val = round val
		@_impl.innerElemStyle.fontSize = "#{val}px"
		return

	setTextInputFontWeight: (val) ->
		@_impl.innerElemStyle.fontWeight = implUtils.getFontWeight val
		return

	setTextInputFontWordSpacing: (val) ->
		@_impl.innerElemStyle.wordSpacing = "#{val}px"
		return

	setTextInputFontLetterSpacing: (val) ->
		@_impl.innerElemStyle.letterSpacing = "#{val}px"
		return

	setTextInputFontItalic: (val) ->
		@_impl.innerElemStyle.fontStyle = if val then 'italic' else 'normal'
		return

	setTextInputAlignmentHorizontal: (val) ->
		@_impl.innerElemStyle.textAlign = val
		return

	setTextInputAlignmentVertical: (val) ->
		@_impl.verticalAlignment = val
		updateVerticalAlignment.call @
		return
