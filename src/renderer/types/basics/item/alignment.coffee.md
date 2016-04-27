Alignment @extension
====================

	'use strict'

	assert = require 'neft-assert'
	utils = require 'neft-utils'

*Alignment* Alignment()
-----------------------

	module.exports = (Renderer, Impl, itemUtils) -> (ctor) -> class Alignment extends itemUtils.DeepObject
		@__name__ = 'Alignment'

		itemUtils.defineProperty
			constructor: ctor
			name: 'alignment'
			defaultValue: null
			valueConstructor: Alignment
			setter: (_super) -> (val) ->
				{alignment} = @
				if utils.isObject val
					alignment.horizontal = val.horizontal if val.horizontal?
					alignment.vertical = val.vertical if val.vertical?
				else
					alignment.horizontal = alignment.vertical = val

				_super.call @, val
				return

		constructor: (ref) ->
			super ref
			@_horizontal = 'left'
			@_vertical = 'top'

			Object.preventExtensions @

*String* Alignment::horizontal = 'left'
---------------------------------------

## *Signal* Alignment::onHorizontalChange(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'horizontal'
			defaultValue: 'left'
			namespace: 'alignment'
			parentConstructor: ctor
			implementation: Impl["set#{ctor.__name__}AlignmentHorizontal"]
			developmentSetter: (val) ->
				assert.isString val
			setter: (_super) -> (val='left') ->
				_super.call @, val

*String* Alignment::vertical = 'top'
------------------------------------

## *Signal* Alignment::onVerticalChange(*String* oldValue)

		itemUtils.defineProperty
			constructor: @
			name: 'vertical'
			defaultValue: 'top'
			namespace: 'alignment'
			parentConstructor: ctor
			implementation: Impl["set#{ctor.__name__}AlignmentVertical"]
			developmentSetter: (val) ->
				assert.isString val
			setter: (_super) -> (val='top') ->
				_super.call @, val

		toJSON: ->
			horizontal: @horizontal
			vertical: @vertical
