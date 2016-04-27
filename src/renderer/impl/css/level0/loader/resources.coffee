'use strict'

module.exports = (impl) ->
	loadResources: (resources) ->
		self = @

		length = 1
		loaded = 0

		onLoaded = ->
			self.progress = ++loaded / length
			return

		load = ->
			if document.readyState is 'complete'
				for resource in resources
					for _, resolutions of resource.paths
						for resolution, path of resolutions
							length++
							img = document.createElement 'img'
							img.onload = img.onerror = onLoaded
							img.src = path
			return

		if document.readyState is 'complete'
			load()
		else
			document.addEventListener 'readystatechange', load


		onLoaded()