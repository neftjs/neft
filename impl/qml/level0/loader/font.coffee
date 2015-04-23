'use strict'

signal = require 'signal'

module.exports = (impl) ->
	{items} = impl

	impl.fonts = {}
	signal.create impl, 'fontLoaded'

	loadFont: (source, name) ->
		onLoaded = ->
			if @status is FontLoader.Ready
				impl.fonts[name] = @name
				impl.fontLoaded name
			return

		if rsc = impl.Renderer.resources.getResource(source)
			source = 'qrc:/' + rsc.getPath()
		else
			source = impl.utils.toUrl(source)

		elem = impl.utils.createQmlObject 'FontLoader {}'
		elem.name = name.toLowerCase()
		elem.source = source

		if elem.status is FontLoader.Ready
			onLoaded.call elem
		else
			elem.onStatusChanged.connect elem, onLoaded

		return