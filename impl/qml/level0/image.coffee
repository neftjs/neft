'use strict'

DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

module.exports = (impl) ->
	{Item} = impl.Types

	DATA =
		isSvg: false
		callback: null

	onSvgImageResize = ->
		if this.sourceSize.width < this.width
			this.sourceSize.width = this.width * 1.2
		if this.sourceSize.height < this.height
			this.sourceSize.height = this.height * 1.2

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		data.elem ?= impl.utils.createQmlObject 'Image { asynchronous: true }'

		Item.create.call @, data

	setImageSource: do ->
		onStatusChanged = ->
			{elem, callback} = @_impl
			elem.statusChanged.disconnect @, onStatusChanged

			if elem.status is Image.Ready
				callback?.call @, null, width: elem.sourceSize.width, height: elem.sourceSize.height
			else
				callback?.call @, true

		(val, callback) ->
			data = @_impl
			{elem} = data

			data.callback = callback

			unless DATA_URI_RE.test val
				val = impl.utils.toUrl(val)
			elem.source = val or ''

			if ///^data:image\/svg+|\.svg$///.test val
				elem.fillMode = Image.PreserveAspectFit
				unless data.isSvg
					elem.widthChanged.connect elem, onSvgImageResize
					elem.heightChanged.connect elem, onSvgImageResize
					elem.statusChanged.connect elem, onSvgImageResize
					data.isSvg = true
			else
				elem.fillMode = Image.Stretch
				if data.isSvg
					elem.widthChanged.disconnect elem, onSvgImageResize
					elem.heightChanged.disconnect elem, onSvgImageResize
					elem.statusChanged.disconnect elem, onSvgImageResize
					data.isSvg = false

			switch elem.status
				when Image.Null
					callback?.call @, true
				when Image.Ready
					callback?.call @, null, width: elem.sourceSize.width, height: elem.sourceSize.height
				when Image.Error
					callback?.call @, true
				when Image.Loading
					elem.statusChanged.connect @, onStatusChanged
				else
					throw new Error "Unsupported image status #{elem.status}"
