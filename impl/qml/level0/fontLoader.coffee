'use strict'

signal = require 'signal'

module.exports = (impl) ->
	{items} = impl

	impl.fonts = {}
	signal.create impl, 'fontLoaded'

	loadFont: (sources, name) ->
		onLoaded = ->
			if @status is FontLoader.Ready
				impl.fonts[name] = @name
				impl.fontLoaded name
			return

		elem = impl.utils.createQmlObject 'FontLoader {}'
		elem.name = name.toLowerCase()
		elem.source = impl.utils.toUrl(sources[0])

		if elem.status is FontLoader.Ready
			onLoaded.call elem
		else
			elem.onStatusChanged.connect elem, onLoaded

		return