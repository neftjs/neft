'use strict'

module.exports = (impl) ->
	{items} = impl

	loadFont: (sources, name) ->
		elem = impl.utils.createQmlObject 'FontLoader {}'
		elem.name = name.toLowerCase()
		elem.source = impl.utils.toUrl(sources[0])
		stylesWindow.fonts[elem.name] = elem