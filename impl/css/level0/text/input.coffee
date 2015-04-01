'use strict'

signal = require 'signal'

module.exports = (impl) ->
	DATA =
		isMultiLine: false
		autoWidth: false
		autoHeight: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Text', DATA

	create: (data) ->
		self = @

		data.elem ?= document.createElement 'textarea'
		data.elem.setAttribute 'class', 'text'
		data.textElem = data.elem
		data.textElemStyle = data.textElem.style

		impl.Types.Item.create.call @, data

		data.elem.addEventListener impl._SIGNALS.pointerWheel, (e) ->
			if document.activeElement is @
				e.stopPropagation()
			return

		data.elem.addEventListener 'input', ->
			if not data.isMultiLine and ///\n///.test(@value)
				@value = @value.replace ///\n///g, ''
			self.text = @value
			return

		impl.setItemWidth.call @, 200
		impl.setItemHeight.call @, 50

		return

	setTextInputIsMultiLine: (val) ->
		@_impl.isMultiLine = val
		@text = @text.replace ///\n///g, ''