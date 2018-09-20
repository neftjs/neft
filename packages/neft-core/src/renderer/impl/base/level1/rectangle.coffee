'use strict'

module.exports = (impl) ->
    {items} = impl
    {round} = Math

    NOP = ->

    getRectangleSource = (item) ->
        data = item._impl
        {pixelRatio} = impl

        if item.width <= 0 or item.height <= 0
            data.isRectVisible = false
            return null
        else
            data.isRectVisible = true

        width = round item.width * pixelRatio
        height = round item.height * pixelRatio
        radius = round item.radius * pixelRatio
        strokeWidth = round Math.min(item.border.width * 2 * pixelRatio, width, height)
        color = data.color
        borderColor = data.borderColor

        "data:image/svg+xml;utf8," +
        "<svg width='#{width}' height='#{height}' xmlns='http://www.w3.org/2000/svg'>" +
            "<clipPath id='clip'>" +
                "<rect " +
                    "rx='#{radius}' " +
                    "width='#{width}' height='#{height}' />" +
            "</clipPath>" +
            "<rect " +
                "clip-path='url(#clip)' " +
                "fill='#{color}' " +
                "stroke='#{borderColor}' " +
                "stroke-width='#{strokeWidth}' " +
                "rx='#{radius}' " +
                "width='#{width}' height='#{height}' />" +
        "</svg>"

    updateImage = ->
        impl.setImageSource.call @, getRectangleSource(@), NOP
        return

    updateImageIfNeeded = ->
        if not @_impl.isRectVisible or @radius > 0 or @border.width > 0
            updateImage.call @
        return

    DATA =
        color: 'transparent'
        borderColor: 'transparent'
        isRectVisible: false

    DATA: DATA

    createData: impl.utils.createDataCloner 'Image', DATA

    create: (data) ->
        impl.Types.Image.create.call @, data

        @onWidthChange updateImageIfNeeded
        @onHeightChange updateImageIfNeeded

    setRectangleColor: (val) ->
        @_impl.color = val
        updateImage.call @

    setRectangleRadius: updateImage

    setRectangleBorderColor: (val) ->
        @_impl.borderColor = val
        updateImage.call @

    setRectangleBorderWidth: updateImage
