Renderer.Transition
===================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	signal = require 'signal'

	module.exports = (Renderer, Impl, itemUtils) -> class Transition
		@__name__ = 'Transition'

		@DATA =
			animation: null
			property: ''

*Transition* Transition([*Object* options])
-------------------------------------------

		constructor: (opts) ->
			expect().defined(opts).toBe.simpleObject()

			data = Object.create(@constructor.DATA)
			utils.defineProperty @, '_data', null, data
			utils.defineProperty @, '_item', utils.WRITABLE, null

			itemUtils.fill @, opts

			utils.defineProperty @, '_listener', null, @_listener.bind(@)

*Renderer.Animation* Transition::animation
------------------------------------------

### Transition::animationChanged([*Renderer.Animation* oldValue])

		itemUtils.defineProperty @::, 'animation', null, null, (_super) -> (val) ->
			oldVal = @animation
			if oldVal is val
				return

			_super.call @, val

			oldVal?.stop()

			if val
				val.target = @_item
				val.property = @property

*String* Transition::property
-----------------------------

### Transition::propertyChanged(*String* oldValue)

		itemUtils.defineProperty @::, 'property', null, null, (_super) -> (val) ->
			oldVal = @property
			if oldVal is val
				return

			_super.call @, val

			if @_item
				if oldVal
					handlerName = signal.getHandlerName "#{oldVal}Changed"
					@_item[handlerName].disconnect @_listener

				if val
					handlerName = signal.getHandlerName "#{val}Changed"
					@_item[handlerName] @_listener

			@animation?.property = val

		utils.defineProperty @::, '_listener', null, (oldVal) ->
			{animation} = @
			if animation.updatePending
				return

			{progress} = animation
			animation.stop()
			{duration} = animation

			animation.from = oldVal
			animation.to = @_item._data[@property]
			if progress > 0
				animation.duration = duration * progress

			onStopped = ->
				animation.onStopped.disconnect onStopped
				animation.duration = duration
			animation.onStopped onStopped

			animation.play()

		utils.defineProperty @::, '_setItem', null, (val) ->
			oldVal = @_item

			if oldVal is val
				return

			@_item = val

			if @property
				handlerName = signal.getHandlerName "#{@property}Changed"

				if oldVal
					oldVal[handlerName].disconnect @_listener

				if val
					val[handlerName] @_listener

			{animation} = @
			if animation
				animation.target = val
				animation.stop()

			return