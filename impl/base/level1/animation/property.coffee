'use strict'

module.exports = (impl) ->
	{Types, items} = impl
	{Animation} = Types

	DATA =
		target: ''
		property: ''
		duration: 1000
		delay: 0
		from: null
		to: null
		progress: 0

	DATA: DATA

	createData: impl.utils.createDataCloner Animation.DATA, DATA

	create: (data) ->
		Animation.create.call @, data

	setPropertyAnimationTarget: (val) ->
		target = @_impl
		target.target = val
		if target.from is null and target.property
			target.from = @[target.property]

	setPropertyAnimationProperty: (val) ->
		target = @_impl
		target.property = val
		if target.from is null and target.target
			target.from = @[val]

	setPropertyAnimationDuration: (val) ->
		@_impl.duration = val

	setPropertyAnimationDelay: (val) ->
		@_impl.delay = val

	setPropertyAnimationFrom: (val) ->
		@_impl.from = val

	setPropertyAnimationTo: (val) ->
		@_impl.to = val

	getPropertyAnimationProgress: ->
		@_impl.progress