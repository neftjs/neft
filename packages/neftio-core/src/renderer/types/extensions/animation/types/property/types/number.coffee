'use strict'

utils = require '../../../../../../../util'

module.exports = (Renderer, Impl, itemUtils) -> class NumberAnimation extends Renderer.PropertyAnimation
    @__name__ = 'NumberAnimation'

    @New = (opts) ->
        item = new NumberAnimation
        itemUtils.Object.initialize item, opts
        item

    constructor: ->
        super()
        @_from = 0
        @_to = 0
