'use strict'

module.exports = (impl) ->
	{Types, items} = impl

	DATA =
		progress: 0
		internalPropertyName: ''
		propertySetter: null
		isIntegerProperty: false
		easing: 'Linear'

	DATA: DATA

	createData: impl.utils.createDataCloner 'Animation', DATA

	create: (data) ->
		impl.Types.Animation.create.call @, data

	setPropertyAnimationTarget: (val) ->

	setPropertyAnimationProperty: do (_super = impl.setPropertyAnimationProperty) -> (val) ->
		_super.call @, val
		@_impl.dirty = true
		return

	setPropertyAnimationDuration: (val) ->

	setPropertyAnimationStartDelay: (val) ->

	setPropertyAnimationLoopDelay: (val) ->

	setPropertyAnimationFrom: (val) ->

	setPropertyAnimationTo: (val) ->

	setPropertyAnimationUpdateData: (val) ->

	setPropertyAnimationUpdateProperty: (val) ->
		@_impl.dirty = true

	setPropertyAnimationEasingType: (val) ->
		@_impl.easing = val
		@_impl.elem?.easing = val

	getPropertyAnimationProgress: ->
		@_impl.progress
