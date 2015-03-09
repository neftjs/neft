'use strict'

module.exports = (impl) ->
	{Types, items} = impl
	{Animation} = Types

	DATA =
		progress: 0
		internalPropertyName: ''
		propertySetter: null

	DATA: DATA

	createData: impl.utils.createDataCloner Animation.DATA, DATA

	create: (data) ->
		Animation.create.call @, data

	setPropertyAnimationTarget: (val) ->

	setPropertyAnimationProperty: (val) ->
		@_impl.internalPropertyName = "_#{val}"
		@_impl.propertySetter = impl.utils.SETTER_METHODS_NAMES[val]
		return

	setPropertyAnimationDuration: (val) ->

	setPropertyAnimationPlayDelay: (val) ->

	setPropertyAnimationLoopDelay: (val) ->

	setPropertyAnimationFrom: (val) ->

	setPropertyAnimationTo: (val) ->

	setPropertyAnimationUpdateData: (val) ->

	setPropertyAnimationUpdateProperty: (val) ->

	getPropertyAnimationProgress: ->
		@_impl.progress
