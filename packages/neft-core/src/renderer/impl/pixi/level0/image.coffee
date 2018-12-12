'use strict'

utils = require '../../../../util'
PIXI = require '../pixi.lib.js'

module.exports = (impl) ->
    {pixelRatio} = impl

    cssUtils = require('../../css/utils')
    cssImage = require('../../css/level0/image') impl

    if utils.isEmpty(PIXI)
        return require('../../base/level0/image') impl

    emptyTexture = PIXI.Texture.EMPTY

    updateSize = ->
        data = @_impl
        if data.isTiling and data.image
            {tileScale} = data.contentElem
            tileScale.x = (data.width / data.image.width) * (data.sourceWidth / data.image.width)
            tileScale.y = (data.height / data.image.height) * (data.sourceHeight / data.image.height)
        return

    replaceContentElem = (type) ->
        data = @_impl
        data.isTiling = type is 'TilingSprite'
        data.elem.removeChild data.contentElem
        if data.isTiling
            data.contentElem = new PIXI.extras.TilingSprite data.contentElem.texture
        else
            data.contentElem = new PIXI.Sprite data.contentElem.texture
        data.elem.addChild data.contentElem
        return

    onSvgImageResize = ->
        data = @_impl
        {image, contentElem} = data
        tex = image.texture
        baseTex = tex?.baseTexture

        if not tex or baseTex.width < @width * pixelRatio or baseTex.height < @height * pixelRatio
            canvas = baseTex?.source or document.createElement('canvas')
            ctx = canvas.getContext '2d'

            canvas.width = width = @width * 1.2 * pixelRatio or 1
            canvas.height = height = @height * 1.2 * pixelRatio or 1
            ctx.drawImage image.elem, 0, 0, image.width, image.height, 0, 0, width, height
            if tex
                tex.update()
            else
                image.texture = new PIXI.Texture new PIXI.BaseTexture(canvas)
                contentElem.texture = image.texture
            for item in image.svgItems
                itemData = item._impl
                itemData.contentElem.scale.x = itemData.contentElem.scale.y = 1
                itemData.contentElem.width = itemData.width
                itemData.contentElem.height = itemData.height
            impl._dirty = true
        return

    DATA =
        isTiling: false
        image: null
        source: ''
        callback: null
        contentElem: null
        sourceWidth: 0
        sourceHeight: 0
        isSvg: false

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        impl.Types.Item.create.call @, data

        data.contentElem = new PIXI.Sprite emptyTexture
        data.elem.addChild data.contentElem
        @onWidthChange.connect updateSize
        @onHeightChange.connect updateSize
        return

    setImageSource: (val, callback) ->
        self = @
        data = @_impl
        {contentElem} = data

        if data.isSvg
            utils.remove data.image.svgItems, self
            self.onWidthChange.disconnect onSvgImageResize
            self.onHeightChange.disconnect onSvgImageResize
            data.isSvg = false

        data.source = val
        data.callback = (err, opts) ->
            impl._dirty = true

            contentElem.texture = emptyTexture

            if not err and val?
                if ///^data:image\/svg+|\.svg$///.test(val)
                    data.image.svgItems ||= []
                    data.image.svgItems.push self
                    onSvgImageResize.call self
                    unless data.isSvg
                        self.onWidthChange.connect onSvgImageResize
                        self.onHeightChange.connect onSvgImageResize
                        data.isSvg = true
                unless data.image.texture
                    img = data.image.elem
                    data.image.texture = new PIXI.Texture new PIXI.BaseTexture(img)
                contentElem.texture = data.image.texture
                impl._dirty = true

                contentElem.scale.x = contentElem.scale.y = 1
                contentElem.width = data.width
                contentElem.height = data.height
                updateSize.call @
            callback?.call @, err, opts

        data.image = cssImage._getImage val
        cssImage._callCallback.call @

        unless /^data:/.test(val)
            data.image.elem.crossOrigin = ''

        return
