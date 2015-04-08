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

		data.elem.addEventListener 'focus', ->
			self.keys.focus = true

		data.elem.addEventListener 'blur', ->
			self.keys.focus = false

		impl.setItemWidth.call @, 200
		impl.setItemHeight.call @, 50

		return

	setText: do (_super = impl.setText) -> (val) ->
		if @_impl.isMultiLine isnt undefined
			@_impl.elem.value = val
		else
			_super.call @, val
		return

	setTextInputIsMultiLine: (val) ->
		@_impl.isMultiLine = val
		@text = @text.replace ///\n///g, ''
		return
