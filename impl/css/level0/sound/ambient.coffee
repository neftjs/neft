'use strict'

module.exports = (impl) ->
	DATA =
		bindings: null
		elem: null

	DATA: DATA

	createData: impl.utils.createDataCloner DATA

	create: (data) ->
		self = @

		elem = data.elem = document.createElement 'audio'
		elem.setAttribute 'preload', 'auto'

		elem.addEventListener 'ended', ->
			self.running = false

		return

	setAmbientSoundSource: (val) ->
		@_impl.elem.setAttribute 'src', val
		return

	setAmbientSoundLoop: (val) ->
		@_impl.elem.setAttribute 'loop', val
		return

	startAmbientSound: (val) ->
		@_impl.elem.play()
		return

	stopAmbientSound: (val) ->
		@_impl.elem.pause()
		@_impl.elem.currentTime = 0
		return
