'use strict'

canvas = document.createElement 'canvas'
ctx = canvas.getContext '2d'

window.svgToImage = (dataUri, width, height, callback) ->
	img = new Image
	img.src = "data:image/svg+xml;utf8,#{atob(dataUri)}"

	onLoaded = ->
		if width isnt 0
			img.width = width
		if height isnt 0
			img.height = height

		width = canvas.width = img.width
		height = canvas.height = img.height

		ctx.drawImage img, 0, 0

		callback canvas.toDataURL "image/png"

	onError = ->
		callback ""

	if img.naturalWidth > 0
		onLoaded()
	else
		img.onload = onLoaded
		img.onerror = onError

	return
