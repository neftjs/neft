'use strict'

module.exports = (impl) ->
	DATA =
		bindings: null
		animation: null
		running: false
		loop: false

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		data.animation = @

	setAnimationLoop: (val) ->
		@_impl.loop = val

	playAnimation: (id) ->
		@_impl.running = true
		@_impl.play()

	stopAnimation: (id) ->
		@_impl.running = false
