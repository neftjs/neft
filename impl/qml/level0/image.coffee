'use strict'

DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

module.exports = (impl) ->
	{Item} = impl.Types

	DATA =
		isSvg: false

	onSvgImageResize = ->
		if this.sourceSize.width < this.width
			this.sourceSize.width = this.width * 1.2
		if this.sourceSize.height < this.height
			this.sourceSize.height = this.height * 1.2

	DATA: DATA

	createData: impl.utils.createDataCloner Item.DATA, DATA

	create: (data) ->
		data.elem ?= impl.utils.createQmlObject 'Image { asynchronous: true }'

		Item.create.call @, data

	setImageSource: (val, callback) ->
		data = @_impl
		{elem} = data

		unless DATA_URI_RE.test val
			val = impl.utils.toUrl(val)
		elem.source = val

		if ///^data:image\/svg+|\.svg$///
			elem.fillMode = Image.PreserveAspectFit
			unless data.isSvg
				elem.widthChanged.connect elem, onSvgImageResize
				elem.heightChanged.connect elem, onSvgImageResize
				elem.statusChanged.connect elem, onSvgImageResize
		else
			elem.fillMode = Image.Stretch
			if data.isSvg
				elem.widthChanged.disconnect elem, onSvgImageResize
				elem.heightChanged.disconnect elem, onSvgImageResize
				elem.statusChanged.disconnect elem, onSvgImageResize
				data.isSvg = false

		switch elem.status
			when Image.Null
				callback "No image set"
			when Image.Ready
				callback null, width: elem.sourceSize.width, height: elem.sourceSize.height
			when Image.Error
				callback "Can't load image"
			when Image.Loading
				onStatusChanged = ->
					elem.statusChanged.disconnect onStatusChanged

					if elem.status is Image.Ready
						callback null, width: elem.sourceSize.width, height: elem.sourceSize.height
					else
						callback "Can't load image"

				elem.statusChanged.connect onStatusChanged
			else
				throw new Error "Unsupported image status #{elem.status}"
