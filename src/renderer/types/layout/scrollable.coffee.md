Scrollable @class
==========

    'use strict'

    utils = require 'src/utils'
    signal = require 'src/signal'
    assert = require 'src/assert'

    {emitSignal} = signal.Emitter

    module.exports = (Renderer, Impl, itemUtils) -> class Scrollable extends Renderer.Item
        @__name__ = 'Scrollable'
        @__path__ = 'Renderer.Scrollable'

*Scrollable* Scrollable.New([*Component* component, *Object* options])
----------------------------------------------------------------------

        @New = (component, opts) ->
            item = new Scrollable
            itemUtils.Object.initialize item, component, opts
            item.clip = true
            item

*Scrollable* Scrollable() : *Renderer.Item*
-------------------------------------------

        constructor: ->
            super()
            @_contentItem = null
            @_contentX = 0
            @_contentY = 0
            @_snap = false
            @_snapItem = null

*Boolean* Scrollable::clip = true
---------------------------------

*Renderer.Item* Scrollable::contentItem = null
----------------------------------------------

## *Signal* Scrollable::onContentItemChange([*Renderer.Item* oldValue])

        itemUtils.defineProperty
            constructor: @
            name: 'contentItem'
            defaultValue: null
            implementation: Impl.setScrollableContentItem
            setter: (_super) -> (val) ->
                if val?
                    assert.instanceOf val, Renderer.Item
                    val.parent = null
                    val._parent = this
                    emitSignal val, 'onParentChange', null
                _super.call @, val

*Float* Scrollable::contentX = 0
--------------------------------

## *Signal* Scrollable::onContentXChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'contentX'
            defaultValue: 0
            implementation: Impl.setScrollableContentX
            developmentSetter: (val) ->
                assert.isFloat val

*Float* Scrollable::contentY = 0
--------------------------------

## *Signal* Scrollable::onContentYChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'contentY'
            defaultValue: 0
            implementation: Impl.setScrollableContentY
            developmentSetter: (val) ->
                assert.isFloat val

Hidden *Boolean* Scrollable::snap = false
-----------------------------------------

## Hidden *Signal* Scrollable::onSnapChange(*Boolean* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'snap'
            defaultValue: false
            implementation: Impl.setScrollableSnap
            developmentSetter: (val) ->
                assert.isBoolean val

Hidden *Renderer.Item* Scrollable::snapItem
-------------------------------------------

## Hidden *Signal* Scrollable::onSnapItemChange(*Renderer.Item* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'snapItem'
            defaultValue: null
            implementation: Impl.setScrollableSnapItem
            developmentSetter: (val=null) ->
                if val?
                    assert.instanceOf val, Renderer.Item
