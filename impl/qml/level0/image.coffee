'use strict'

module.exports = (impl) ->
	{Item} = impl.Types

	DATA =
		shader: null
		isSvg: false
		callback: null
		size: {width: 0, height: 0}
		resource: null

	onSvgImageResize = ->
		if this.sourceSize.width < this.width
			this.sourceSize.width = this.width * 1.2
		if this.sourceSize.height < this.height
			this.sourceSize.height = this.height * 1.2
		return

	useShader = (item) ->
		data = item._impl

		data.shader = impl.utils.createQmlObject """
		Item {
			id: shader;
			property variant image: null;
			property double offsetX: 0;
			property double offsetY: 0;
			property int xDir: 1;
			property int yDir: 1;
			anchors.fill: this.image;
			clip: true;

			onOffsetXChanged: {
				this.updateOffset();
			}
			onOffsetYChanged: {
				this.updateOffset();
			}
			onWidthChanged: {
				this.updateSize();
			}
			onHeightChanged: {
				this.updateSize();
			}
			onXDirChanged: {
				this.updateDir();
			}
			onYDirChanged: {
				this.updateDir();
			}

			function updateSize(){
				this.updateImages();
				this.updateOffset();
			}

			function updateDir(){
				var children = this.children,
				    c00 = children[0],
				    c10 = children[1],
				    c01 = children[2],
				    c11 = children[3];
				c10.baseX = c11.baseX = c00.width * this.xDir * -1;
				c01.baseY = c11.baseY = c00.height * this.yDir * -1;
			}

			function updateImages(){
				var children = this.children,
				    width = Math.floor(this.width / this.image.width) * this.image.width,
				    height = Math.floor(this.height / this.image.height) * this.image.height;
				if (!isFinite(width) || !isFinite(height)){
					return;
				}

				for (var i = 0; i < 4; i++){
					var child = children[i];
					child.width = width;
					child.height = height;
				}

				this.updateDir();
			}

			function updateOffset(){
				var children = this.children,
				    offsetX = this.offsetX % this.width,
				    offsetY = this.offsetY % this.height;
				if (children.length !== 5){
					return;
				}

				for (var i = 0; i < 4; i++){
					var child = children[i];
					child.offsetX = offsetX;
					child.offsetY = offsetY;
				}

				this.xDir = offsetX > 0 ? 1 : -1;
				this.yDir = offsetY > 0 ? 1 : -1;
			}

			Repeater {
				model: 4;

				Image {
					source: shader.image ? shader.image.source : '';
					sourceSize.width: shader.image ? shader.image.sourceSize.width : 0;
					sourceSize.height: shader.image ? shader.image.sourceSize.height : 0;
					fillMode: Image.Tile;
					property double offsetX: 0;
					property double offsetY: 0;
					property double baseX: 0;
					property double baseY: 0;
					x: this.baseX + this.offsetX;
					y: this.baseY + this.offsetY;
				}
			}
		}
		""", data.elem.parent

		# TODO: what with elem children and items order
		data.shader.image = data.elem

		return

	DATA: DATA

	createData: impl.utils.createDataCloner 'Item', DATA

	create: (data) ->
		data.elem ?= impl.utils.createQmlObject 'Image { asynchronous: true }'

		Item.create.call @, data

	setImageSource: do ->
		onStatusChanged = ->
			data = @_impl
			{elem, callback} = data
			elem.statusChanged.disconnect @, onStatusChanged

			if elem.status is Image.Ready
				data.size.width = data.resource?.width or elem.sourceSize.width
				data.size.height = data.resource?.height or elem.sourceSize.height
				callback?.call @, null, data.size
			else if elem.status is Image.Error
				callback?.call @, true

		(val, callback) ->
			data = @_impl
			{elem} = data

			data.callback = callback
			data.resource = null

			unless impl.utils.DATA_URI_RE.test(val)
				if rsc = impl.Renderer.resources.getResource(val)
					data.resource = rsc
					val = 'qrc:' + rsc.resolve()
				else
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
				when Image.Ready, Image.Error
					onStatusChanged.call @
				else
					elem.statusChanged.connect @, onStatusChanged
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
		# unless @_impl.shader
		# 	useShader @
		# @_impl.shader.offsetX = val
		return

	setImageOffsetY: (val) ->
		# unless @_impl.shader
		# 	useShader @
		# @_impl.shader.offsetY = val
		return
