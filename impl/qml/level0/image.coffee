'use strict'

DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

module.exports = (impl) ->
	{Item} = impl.Types

	DATA =
		svgImageResizeListener: null

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
			unless data.svgImageResizeListener
				data.svgImageResizeListener = ->
					onSvgImageResize.call elem
				elem.widthChanged.connect data.svgImageResizeListener
				elem.heightChanged.connect data.svgImageResizeListener
				elem.statusChanged.connect data.svgImageResizeListener
		else
			elem.fillMode = Image.Stretch
			if data.svgImageResizeListener
				elem.widthChanged.disconnect data.svgImageResizeListener
				elem.heightChanged.disconnect data.svgImageResizeListener
				elem.statusChanged.disconnect data.svgImageResizeListener
				data.svgImageResizeListener = null

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
