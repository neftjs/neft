'use strict'

module.exports = (impl) ->
	DATA =
		bindings: null

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		data.animation = @

	setAnimationLoop: (val) ->

	playAnimation: ->

	stopAnimation: ->
