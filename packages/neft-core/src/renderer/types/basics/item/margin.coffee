'use strict'

utils = require '../../../../util'
{SignalsEmitter} = require '../../../../signal'
assert = require '../../../../assert'

module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor, opts) -> class Margin extends itemUtils.DeepObject
    @__name__ = 'Margin'

    propertyName = opts?.propertyName or 'margin'

    itemUtils.defineProperty
        constructor: ctor
        name: propertyName
        defaultValue: 0
        valueConstructor: Margin
        setter: (_super) -> (val=0) ->
            margin = @[propertyName]
            if typeof val is 'string'
                arr = val.split ' '
                for elem, i in arr
                    arr[i] = parseFloat elem
                switch arr.length
                    when 3
                        margin.top = arr[0]
                        margin.right = arr[1]
                        margin.bottom = arr[2]
                        margin.left = arr[1]
                    when 2
                        margin.top = arr[0]
                        margin.right = arr[1]
                        margin.bottom = arr[0]
                        margin.left = arr[1]
                    when 1
                        margin.left = margin.top = margin.right = margin.bottom = arr[0]
                    else
                        margin.top = arr[0]
                        margin.right = arr[1]
                        margin.bottom = arr[2]
                        margin.left = arr[3]
            else if Array.isArray(val)
                margin.top = val[0] if val.length > 0
                margin.right = val[1] if val.length > 1
                margin.bottom = val[2] if val.length > 2
                margin.left = val[3] if val.length > 3
            else if utils.isObject(val)
                margin.left = val.left if val.left?
                margin.top = val.top if val.top?
                margin.right = val.right if val.right?
                margin.bottom = val.bottom if val.bottom?
            else
                margin.left = margin.top = margin.right = margin.bottom = val
            _super.call @, val
            return

    constructor: (ref) ->
        super ref
        @_left = 0
        @_top = 0
        @_right = 0
        @_bottom = 0

        Object.preventExtensions @

    createMarginProp = (type, extraProp) ->
        developmentSetter = (val) ->
            assert typeof val is 'number' and isFinite(val)
            , "margin.#{type} expects a finite number; `#{val}` given"

        extraPropSignal = "on#{utils.capitalize(extraProp)}Change"
        itemUtils.defineProperty
            constructor: Margin
            name: type
            defaultValue: 0
            setter: (_super) -> (val) ->
                extraOldVal = @[extraProp]
                _super.call @, val
                @emit extraPropSignal, extraOldVal
            namespace: propertyName
            parentConstructor: ctor
            developmentSetter: developmentSetter

    createMarginProp 'left', 'horizontal'

    createMarginProp 'top', 'vertical'

    createMarginProp 'right', 'horizontal'

    createMarginProp 'bottom', 'vertical'

    SignalsEmitter.createSignal @, 'onHorizontalChange'

    utils.defineProperty @::, 'horizontal', null, ->
        @_left + @_right
    , (val) ->
        @left = @right = val / 2

    SignalsEmitter.createSignal @, 'onVerticalChange'

    utils.defineProperty @::, 'vertical', null, ->
        @_top + @_bottom
    , (val) ->
        @top = @bottom = val / 2

    valueOf: ->
        if @left is @top and @top is @right and @right is @bottom
            @left
        else
            throw new Error "margin values are different"

    toJSON: ->
        left: @left
        top: @top
        right: @right
        bottom: @bottom
