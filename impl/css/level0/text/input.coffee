'use strict'

signal = require 'signal'

module.exports = (impl) ->
	SHEET = """
		textarea.text {
			width: 100%;
			height: 100%;
		}
		textarea.text.textVerticalCenterAlign {
			height: 100% !important;
			top: 0;
			#{impl.utils.transformCSSProp}: none;
		}
	"""

	window.addEventListener 'load', ->
		styles = document.createElement 'style'
		styles.innerHTML = SHEET
		document.body.appendChild styles

	DATA =
		autoWidth: false
		autoHeight: false
		isMultiLine: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Text', DATA

	create: (data) ->
		self = @

		impl.Types.Item.create.call @, data
		innerElem = data.innerElem = document.createElement 'textarea'
		data.innerElemStyle = innerElem.style
		innerElem.setAttribute 'class', 'text'
		data.elem.appendChild innerElem

		data.elem.addEventListener impl._SIGNALS.pointerOnWheel, (e) ->
			if document.activeElement is innerElem
				e.stopPropagation()
			return

		innerElem.addEventListener 'focus', ->
			self.keys.focus = true
		innerElem.addEventListener 'blur', ->
			self.keys.focus = false

		@onTextChange ->
			innerElem.value = @text
		innerElem.addEventListener 'input', ->
			self.text = innerElem.value

		impl.setItemWidth.call @, 200
		impl.setItemHeight.call @, 50

		return

	setTextInputMultiLine: (val) ->
		@_impl.isMultiLine = val
		@text = @text.replace ///\n///g, ''
		return
