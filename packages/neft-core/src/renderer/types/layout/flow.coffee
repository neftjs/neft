'use strict'

assert = require '../../../assert'
utils = require '../../../util'

module.exports = (Renderer, Impl, itemUtils) -> class Flow extends Renderer.Item
    @__name__ = 'Flow'
    @__path__ = 'Renderer.Flow'

    @New = (opts) ->
        item = new Flow
        itemUtils.Object.initialize item, opts
        item.effectItem = item
        item

    constructor: ->
        super()
        @_padding = null
        @_spacing = null
        @_alignment = null
        @_includeBorderMargins = false
        @_collapseMargins = false
        @_effectItem = null

    utils.defineProperty @::, 'effectItem', null, ->
        @_effectItem
    , (val) ->
        if val?
            assert.instanceOf val, Renderer.Item
        oldVal = @_effectItem
        @_effectItem = val
        Impl.setFlowEffectItem.call @, val, oldVal

    Renderer.Item.createMargin @,
        propertyName: 'padding'

    Renderer.Item.createSpacing @

    Renderer.Item.createAlignment @

    itemUtils.defineProperty
        constructor: @
        name: 'includeBorderMargins'
        defaultValue: false
        implementation: Impl.setFlowIncludeBorderMargins
        developmentSetter: (val) ->
            assert.isBoolean val

    itemUtils.defineProperty
        constructor: @
        name: 'collapseMargins'
        defaultValue: false
        implementation: Impl.setFlowCollapseMargins
        developmentSetter: (val) ->
            assert.isBoolean val
