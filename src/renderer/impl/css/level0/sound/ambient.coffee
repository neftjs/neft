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
		if rsc = impl.Renderer.resources.resolve(val)
			val = rsc
		@_impl.elem.setAttribute 'src', val
		return

	setAmbientSoundLoop: (val) ->
		@_impl.elem.setAttribute 'loop', val
		return

	startAmbientSound: (val) ->
		@_impl.elem.play()
		if @_impl.elem.readyState is @_impl.elem.HAVE_ENOUGH_DATA
			@_impl.elem.currentTime = 0
		return

	stopAmbientSound: (val) ->
		@_impl.elem.pause()
		return
