'use strict'

utils = require '../../../../util'
signal = require '../../../../signal'
PIXI = require '../pixi.lib.js'

isTouch = 'ontouchstart' of window

module.exports = (impl) ->
    cssUtils = require '../../css/utils'

    if utils.isEmpty PIXI
        return require('../../base/level0/item') impl

    {round} = Math

    updateMask = (item) ->
        data = item._impl
        {elem} = data
        {mask} = elem

        mask.clear()
        mask.beginFill()
        mask.drawRect 0, 0, data.width, data.height
        mask.endFill()
        return

    DATA = utils.merge
        bindings: null
        anchors: null
        elem: null
        x: 0
        y: 0
        width: 0
        height: 0
        scale: 1
    , impl.ITEM_DATA

    DATA: DATA

    createData: impl.utils.createDataCloner DATA

    create: (data) ->
        elem = data.elem = new PIXI.Container
        elem._data = data
        elem.z = 0
        return

    setItemParent: (val) ->
        item = @_impl.elem
        parent = val?._impl.elem
        item.parent?.removeChild item

        if parent
            parent.addChild item

        impl._dirty = true
        return

    setItemVisible: (val) ->
        @_impl.elem.visible = val
        impl._dirty = true
        return

    setItemClip: (val) ->
        {elem} = @_impl

        if val
            # add mask
            mask = new PIXI.Graphics
            elem.mask = mask
            updateMask @
            elem.addChild mask
        else
            # remove mask
            elem.removeChild elem.mask
            elem.mask = null
        return

    setItemWidth: (val) ->
        {elem} = @_impl
        @_impl.width = val
        @_impl.contentElem?.width = val
        if elem.mask?
            updateMask @
        impl._dirty = true
        return

    setItemHeight: (val) ->
        {elem} = @_impl
        @_impl.height = val
        @_impl.contentElem?.height = val
        if elem.mask?
            updateMask @
        impl._dirty = true
        return

    setItemX: (val) ->
        @_impl.x = val
        impl._dirty = true
        return

    setItemY: (val) ->
        @_impl.y = val
        impl._dirty = true
        return

    setItemScale: (val) ->
        @_impl.scale = val
        impl._dirty = true

    setItemRotation: (val) ->
        @_impl.elem.rotation = val
        impl._dirty = true

    setItemOpacity: (val) ->
        @_impl.elem.alpha = val
        impl._dirty = true

    attachItemSignal: (ns, signalName) ->
        if ns is 'pointer'
            impl.pointer.attachItemSignal.call @, signalName
        return
