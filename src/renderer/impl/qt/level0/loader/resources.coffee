'use strict'

module.exports = (impl) ->
	loadResources: (resources) ->
		self = @

		length = 1
		loaded = 0

		onLoaded = ->
			if @status is Image.Ready or @status is Image.Error
				@destroy()
				self.progress = ++loaded / length
			return

		for resource in resources
			for _, resolutions of resource.paths
				for resolution, path of resolutions
					length++
					img = impl.utils.createQmlObject 'Image { asynchronous: true }'
					img.source = 'qrc:' + path
					if img.status is Image.Loading
						img.statusChanged.connect img, onLoaded
					else
						onLoaded.call img

		self.progress = ++loaded / length
		return