'use strict'

module.exports = (impl) ->
	{Types, items} = impl

	DATA =
		progress: 0
		internalPropertyName: ''
		propertySetter: null
		isIntegerProperty: false

	DATA: DATA

	createData: impl.utils.createDataCloner 'Animation', DATA

	create: (data) ->
		impl.Types.Animation.create.call @, data

	setPropertyAnimationTarget: (val) ->

	setPropertyAnimationProperty: (val) ->
		@_impl.internalPropertyName = "_#{val}"
		@_impl.propertySetter = impl.utils.SETTER_METHODS_NAMES[val]
		@_impl.isIntegerProperty = !!impl.utils.INTEGER_PROPERTIES[val]
		return

	setPropertyAnimationDuration: (val) ->

	setPropertyAnimationStartDelay: (val) ->

	setPropertyAnimationLoopDelay: (val) ->

	setPropertyAnimationFrom: (val) ->

	setPropertyAnimationTo: (val) ->

	setPropertyAnimationUpdateData: (val) ->

	setPropertyAnimationUpdateProperty: (val) ->

	getPropertyAnimationProgress: ->
		@_impl.progress
