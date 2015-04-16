'use strict'

DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

module.exports = (impl) ->
	{Item} = impl.Types

	DATA =
		shader: null
		isSvg: false
		callback: null

	onSvgImageResize = ->
		if this.sourceSize.width < this.width
			this.sourceSize.width = this.width * 1.2
		if this.sourceSize.height < this.height
			this.sourceSize.height = this.height * 1.2
		return

	useShader = (item) ->
		data = item._impl

		data.shader = impl.utils.createQmlObject 'ShaderEffect {
			id: shader;
			property variant image: null;
			property double offsetX: 0;
			property double offsetY: 0;
			property double sourceWidth: this.image ? this.image.sourceSize.width : 0;
			property double sourceHeight: this.image ? this.image.sourceSize.height : 0;
			property variant src: ShaderEffectSource {
				sourceItem: shader.image;
				wrapMode: ShaderEffectSource.Repeat;
				hideSource: true;
			}
			onOffsetXChanged: {
				shader.offset.x = -shader.offsetX/shader.sourceWidth;
			}
			onOffsetYChanged: {
				shader.offset.y = -shader.offsetY/shader.sourceHeight;
			}
			onSourceWidthChanged: {
				shader.tile.x = shader.sourceWidth/shader.width;
			}
			onSourceHeightChanged: {
				shader.tile.y = shader.sourceHeight/shader.height;
			}
			property point tile: Qt.point(0, 0);
			property point offset: Qt.point(0, 0);
			width: this.image ? this.image.width : 0;
			height: this.image ? this.image.height : 0;
			vertexShader: "
				uniform highp mat4 qt_Matrix;
				attribute highp vec4 qt_Vertex;
				attribute highp vec2 qt_MultiTexCoord0;
				varying highp vec2 coord;
				void main() {
					coord = qt_MultiTexCoord0;
					gl_Position = qt_Matrix * qt_Vertex;
				}
			";
			fragmentShader: "
				varying highp vec2 coord;
				uniform sampler2D src;
				uniform vec2 tile;
				uniform vec2 offset;
				void main() {
					gl_FragColor = texture2D(src, fract(coord / tile) + offset);
				}
			";
		}'

		# TODO: what with elem children and items order
		data.shader.image = data.elem
		data.shader.parent = data.elem.parent

		return

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
			return

	setImageSourceWidth: (val) ->
		@_impl.elem.sourceSize.width = val
		return

	setImageSourceHeight: (val) ->
		@_impl.elem.sourceSize.height = val
		return

	setImageFillMode: (val) ->
		switch val
			when 'Stretch'
				@_impl.elem.fillMode = Image.Stretch
			when 'Tile'
				@_impl.elem.fillMode = Image.Tile
		return

	setImageOffsetX: (val) ->
		unless @_impl.shader
			useShader @
		@_impl.shader.offsetX = val
		return

	setImageOffsetY: (val) ->
		unless @_impl.shader
			useShader @
		@_impl.shader.offsetY = val
		return
