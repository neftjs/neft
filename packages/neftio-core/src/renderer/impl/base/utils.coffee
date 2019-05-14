utils = require '../../../util'

module.exports = (impl) ->
    INTEGER_PROPERTIES:
        __proto__: null
        x: true
        y: true
        width: true
        height: true

    SETTER_METHODS_NAMES:
        __proto__: null
        'x': 'setItemX'
        'y': 'setItemY'
        'width': 'setItemWidth'
        'height': 'setItemHeight'
        'opacity': 'setItemOpacity'
        'rotation': 'setItemRotation'
        'scale': 'setItemScale'
        'offsetX': 'setImageOffsetX'
        'offsetY': 'setImageOffsetY'
        'sourceWidth': 'setImageSourceWidth'
        'sourceHeight': 'setImageSourceHeight'

    createDataCloner: (extend, base) ->
        ->
            obj = extend
            if base?
                extend = impl.Types[extend].DATA
                obj = utils.clone extend
                utils.merge obj, base
                utils.merge base, obj
            json = JSON.stringify obj
            func = Function "return #{json}"
            func

    radToDeg: do ->
        RAD = 180 / Math.PI
        (val) ->
            val * RAD

    degToRad: do ->
        DEG = Math.PI / 180
        (val) ->
            val * DEG
