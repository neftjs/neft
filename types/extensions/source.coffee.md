Source
======

	'use strict'

	assert = require 'assert'
	utils = require 'utils'
	List = require 'list'

*Source* Source()
-----------------

	module.exports = (Renderer, Impl, itemUtils) ->
		class Source extends Renderer.Extension
			@__name__ = 'Source'

			constructor: ->
				@_effectItem = null
				super()
				@_when = true

				@onReady ->
					@effectItem ?= getDefaultEffectItem @
					if @_when
						@enable()

*Renderer.Item* Source::target
------------------------------

### *Signal* Source::targetChanged(*Renderer.Item* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'target'
				developmentSetter: (val) ->
					if val?
						assert.instanceOf val, Renderer.Item
				setter: (_super) -> (val) ->
					@_effectItem?._sourceItem = val
					_super.call @, val
					return

*Renderer.Item* Source::effectItem
----------------------------------

### *Signal* Source::effectItemChanged(*Renderer.Item* oldValue)

			getDefaultEffectItem = (source) ->
				item = source._target
				next = item
				while next = item.parent
					item = next
				item

			itemUtils.defineProperty
				constructor: @
				name: 'effectItem'
				developmentSetter: (val) ->
					if val?
						assert.instanceOf val, Renderer.Item
				setter: (_super) -> (val) ->
					oldVal = @_effectItem

					if val is @_target
						val = null

					if @running
						if oldVal
							oldVal._sourceItem = null

						if val
							val._sourceItem = @_target

					_super.call @, val
					return

*Boolean* Source::when = true
-----------------------------

### *Signal* Source::whenChanged(*Boolean* oldValue)

			enable: ->
				if @running
					return
				@_effectItem?._sourceItem = @_target
				super()
				return

			disable: ->
				unless @running
					return
				@_effectItem?._sourceItem = null
				super()
				return

		Source
