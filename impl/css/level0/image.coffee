'use strict'

signal = require 'signal'

module.exports = (impl) ->
	{Item} = impl.Types
	{round} = Math

	cache = Object.create null

	createImage = (src) ->
		img = document.createElement 'img'
		img.src = src

		img.addEventListener 'error', ->
			obj.status = 'error'
			obj.loaded()

		img.addEventListener 'load', ->
			obj.status = 'ready'
			obj.width = @naturalWidth or @width
			obj.height = @naturalHeight or @height

			if obj.width is 0 and obj.height is 0 and ///\.svg$///.test(obj.source)
				xhr = new XMLHttpRequest
				xhr.overrideMimeType 'text/xml'
				xhr.open 'get', obj.source, true
				xhr.onload = ->
					{responseXML} = xhr
					svg = responseXML.querySelector 'svg'

					viewBox = svg.getAttribute 'viewBox'
					if viewBox
						viewBox = viewBox.split ' '
					else
						viewBox = [0, 0, 0, 0]

					obj.width = parseFloat(svg.getAttribute('width')) or parseFloat(viewBox[2])
					obj.height = parseFloat(svg.getAttribute('height')) or parseFloat(viewBox[3])

					obj.loaded()
				xhr.onerror = ->
					obj.status = 'error'
					obj.loaded()
				xhr.send()
			else
				obj.loaded()

		obj =
			source: src
			status: 'loading'
			width: 0
			height: 0
			elem: img
		signal.create obj, 'loaded'
		obj

	getImage = (src) ->
		cache[src] ?= createImage(src)

	onImageLoaded = ->
		data = @_impl
		img = data.image

		if img.source is data.source
			callCallback.call @
		return

	callCallback = ->
		data = @_impl
		img = data.image
		{callback} = data

		if img.status is 'ready'
			callback?.call @, null, img
		else if img.status is 'error'
			callback?.call @, true
		else
			img.onLoaded onImageLoaded, @
		return

	useCssBackground = (item) ->
		data = item._impl
		data.useCssBackground = true
		data.elemStyle.backgroundImage = "url('#{data.source}')"
		data.elemStyle.backgroundPosition = '50% 50%'
		data.imgElem.style.display = 'none'
		return

	setBackgroundSize = (item) ->
		data = item._impl

		unless data.useCssBackground
			useCssBackground item

		width = item._sourceWidth
		height = item._sourceHeight
		data.elemStyle.backgroundSize = "#{width}px #{height}px"

		return

	DATA =
		imgElem: null
		callback: null
		source: ''
		image: null
		useCssBackground: false
		offsetX: 0
		offsetY: 0

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	_getImage: getImage
	_callCallback: callCallback

	create: (data) ->
		self = @
		Item.create.call @, data

		imgElem = data.imgElem = document.createElement 'img'
		data.elem.appendChild imgElem
		return

	setImageSource: (val, callback) ->
		val = impl.utils.encodeImageSrc val

		data = @_impl
		data.imgElem.src = val
		data.source = val
		data.callback = callback
		data.image = getImage val

		if data.useCssBackground
			data.elemStyle.backgroundImage = "url('#{val}')"

		callCallback.call @
		return

	setImageSourceWidth: (val) ->
		data = @_impl

		if val isnt data.image.width
			setBackgroundSize @
		return

	setImageSourceHeight: (val) ->
		data = @_impl

		if val isnt data.image.height
			setBackgroundSize @
		return

	setImageFillMode: (val) ->
		data = @_impl

		if val is 'Stretch'
			data.useCssBackground = false
			data.elemStyle.backgroundImage = ''
			data.imgElem.style.display = 'block'
		else
			useCssBackground @

			switch val
				when 'PreserveAspectFit'
					data.elemStyle.backgroundRepeat = 'no-repeat'
				when 'Tile'
					data.elemStyle.backgroundRepeat = 'repeat'

		return

	setImageOffsetX: (val) ->
		data = @_impl
		unless data.useCssBackground
			useCssBackground @
		data.offsetX = val
		data.elemStyle.backgroundPosition = "#{val}px #{data.offsetY}px"
		return

	setImageOffsetY: (val) ->
		data = @_impl
		unless data.useCssBackground
			useCssBackground @
		data.offsetY = val
		data.elemStyle.backgroundPosition = "#{data.offsetY}px #{val}px"
		return
