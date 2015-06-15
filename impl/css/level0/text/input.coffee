'use strict'

signal = require 'signal'

module.exports = (impl) ->
	DATA =
		isMultiLine: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Text', DATA

	create: (data) ->
		self = @

		impl.Types.Text.create.call @, data
		{textElem} = data

		textElem.setAttribute 'contenteditable', 'true'
		data.textElemStyle.overflow = 'auto'

		data.elemStyle.cursor = 'text'

		data.elem.addEventListener impl._SIGNALS.pointerOnWheel, (e) ->
			if document.activeElement is textElem
				e.stopPropagation()
			return

		textElem.addEventListener 'input', ->
			if not data.isMultiLine and ///\n///.test(textElem.textContent)
				textElem.textContent = textElem.textContent.replace ///\n///g, ''
			self.text = textElem.textContent
			return

		data.elem.addEventListener 'click', ->
			textElem.focus()

		textElem.addEventListener 'focus', ->
			self.keys.focus = true

		textElem.addEventListener 'blur', ->
			self.keys.focus = false

		impl.setItemWidth.call @, 200
		impl.setItemHeight.call @, 50

		return

	setTextInputMultiLine: (val) ->
		@_impl.isMultiLine = val
		@text = @text.replace ///\n///g, ''
		return
