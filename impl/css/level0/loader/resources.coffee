'use strict'

module.exports = (impl) ->
	loadResources: (resources) ->
		self = @

		length = 1
		loaded = 0

		onLoaded = ->
			self.progress = ++loaded / length
			return

		for resource in resources
			for _, resolutions of resource.paths
				for resolution, path of resolutions
					length++
					img = document.createElement 'img'
					img.onload = img.onerror = onLoaded
					img.src = path

		onLoaded()