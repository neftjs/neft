'use strict'

utils = require '../../../../util'
implUtils = require '../utils'
log = require '../../../../log'
signal = require '../../../../signal'

log = log.scope 'Renderer', 'CSS Implementation'

{now} = Date

isTouch = 'ontouchstart' of window

SIGNALS_CURSORS =
    pointer:
        onClick: 'pointer'

module.exports = (impl) ->
    LAYER_MIN_OPERATIONS = 8
    LAYER_GC_DELAY = 1000
    USE_GPU = impl.utils.transform3dSupported
    layers = []

    {transformProp, rad2deg} = impl.utils

    implUtils = impl.utils

    if USE_GPU
        setInterval ->
            i = 0
            n = layers.length
            while i < n
                layer = layers[i]
                layer.operations = (layer.operations * 0.5)|0

                if layer.operations < LAYER_MIN_OPERATIONS
                    layer.operations = 0

                    if i is n-1
                        layers.pop()
                    else
                        layers[i] = layers.pop()
                    n--

                    if layer.isLayer
                        layer.elem.setAttribute 'class', ''
                        layer.isLayer = false
                        updateTransforms layer
                        layer.operations = 0
                        console.assert layer.isLayer is false

                    layer.isInLayers = false
                else
                    i++
            return
        , LAYER_GC_DELAY

    updateTransforms = (data) ->
        transform = ''

        if USE_GPU
            unless data.isInLayers
                layers.push data
                data.isInLayers = true

            if not data.isLayer and data.operations >= LAYER_MIN_OPERATIONS
                data.elem.setAttribute 'class', 'layer'
                data.isLayer = true
            else
                data.operations++

        # position
        if data.isLayer
            transform = "translate3d(#{data.x}px, #{data.y}px, 0) "
        else
            transform = "translate(#{data.x}px, #{data.y}px) "

        # rotation
        if data.rotation
            transform += "rotate(#{rad2deg(data.rotation)}deg) "

        # scale
        if data.scale isnt 1
            transform += "scale(#{data.scale}) "

        data.elemStyle[transformProp] = transform
        return

    NOP = ->

    DATA = utils.merge
        bindings: null
        anchors: null
        elem: null
        elemStyle: null
        linkElem: null
        x: 0
        y: 0
        rotation: 0
        scale: 1
        mozFontSubpixel: true
        isLayer: false
        isInLayers: false
        operations: 0
    , impl.ITEM_DATA

    DATA: DATA

    createData: impl.utils.createDataCloner DATA

    create: (data) ->
        data.elem ?= document.createElement 'div'
        data.elemStyle = data.elem.style
        `//<development>`
        data.elem.setAttribute 'neft-debug', @toString()
        `//</development>`

    setItemParent: (val) ->
        self = @
        {elem} = @_impl
        elem.parentElement?.removeChild elem

        if val
            val._impl.elem.appendChild elem
        return

    insertItemBefore: (val) ->
        parent = if val then val._parent else @_parent
        valElem = if val then val._impl.elem else null
        oldParent = @_impl.elem.parentElement
        newParent = parent._impl.elem
        newParent.insertBefore @_impl.elem, valElem
        return

    setItemVisible: (val) ->
        @_impl.elemStyle.display = if val then 'inline' else 'none'
        return

    setItemClip: (val) ->
        @_impl.elemStyle.overflow = if val then 'hidden' else 'visible'
        return

    setItemWidth: (val) ->
        @_impl.elemStyle.width = "#{val}px"
        return

    setItemHeight: (val) ->
        @_impl.elemStyle.height = "#{val}px"
        return

    setItemX: (val) ->
        @_impl.x = val
        updateTransforms @_impl
        return

    setItemY: (val) ->
        @_impl.y = val
        updateTransforms @_impl
        return

    setItemScale: (val) ->
        @_impl.scale = val
        updateTransforms @_impl
        return

    setItemRotation: (val) ->
        @_impl.rotation = val
        updateTransforms @_impl
        return

    setItemOpacity: (val) ->
        @_impl.elemStyle.opacity = val
        return

    attachItemSignal: (ns, signalName) ->
        if ns is 'pointer'
            impl.pointer.attachItemSignal.call @, signalName

        # cursor
        if cursor = SIGNALS_CURSORS[ns]?[signalName]
            @_ref._impl.elemStyle.cursor = cursor
        return
