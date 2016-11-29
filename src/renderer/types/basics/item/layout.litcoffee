# Layout

    'use strict'

    utils = require 'src/utils'
    signal = require 'src/signal'
    assert = require 'src/assert'

    module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor, opts) -> class Layout extends itemUtils.DeepObject
        @__name__ = 'Layout'

        propertyName = opts?.propertyName or 'layout'

        itemUtils.defineProperty
            constructor: ctor
            name: propertyName
            valueConstructor: Layout

        constructor: (ref) ->
            super ref
            @_enabled = true
            @_fillWidth = false
            @_fillHeight = false

            Object.preventExtensions @

## *Boolean* Layout::enabled = `true`

        itemUtils.defineProperty
            constructor: Layout
            name: 'enabled'
            defaultValue: true
            developmentSetter: (val) ->
                assert.isBoolean val
            namespace: propertyName
            parentConstructor: ctor

## *Boolean* Layout::fillWidth = `false`

## *Signal* Layout::onFillWidthChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: Layout
            name: 'fillWidth'
            defaultValue: false
            developmentSetter: (val) ->
                assert.isBoolean val
            namespace: propertyName
            parentConstructor: ctor

## *Boolean* Layout::fillHeight = `false`

## *Signal* Layout::onFillHeightChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: Layout
            name: 'fillHeight'
            defaultValue: false
            developmentSetter: (val) ->
                assert.isBoolean val
            namespace: propertyName
            parentConstructor: ctor
