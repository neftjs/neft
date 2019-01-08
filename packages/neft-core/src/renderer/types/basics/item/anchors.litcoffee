    'use strict'

    utils = require '../../../../util'
    log = require '../../../../log'
    assert = require '../../../../assert'
    signal = require '../../../../signal'

    log = log.scope 'Renderer'

    H_LINE = 1<<0
    V_LINE = 1<<1

    LINE_REQ = 1<<0
    ONLY_TARGET_ALLOW = 1<<1
    H_LINE_REQ = 1<<2
    V_LINE_REQ = 1<<3
    FREE_H_LINE_REQ = 1<<4
    FREE_V_LINE_REQ = 1<<5

    H_LINES =
        top: true
        bottom: true
        verticalCenter: true

    V_LINES =
        left: true
        right: true
        horizontalCenter: true

    module.exports = (Renderer, Impl, itemUtils, Item) -> (ctor) -> class Anchors extends itemUtils.DeepObject
        @__name__ = 'Anchors'

        itemUtils.defineProperty
            constructor: ctor
            name: 'anchors'
            valueConstructor: Anchors
            developmentSetter: (val) ->
                assert.isObject val
            setter: (_super) -> (val) ->
                {anchors} = @
                anchors.left = val.left if val.left?
                anchors.right = val.right if val.right?
                anchors.horizontalCenter = val.horizontalCenter if val.horizontalCenter?
                anchors.top = val.top if val.top?
                anchors.bottom = val.bottom if val.bottom?
                anchors.verticalCenter = val.verticalCenter if val.verticalCenter?
                anchors.centerIn = val.centerIn if val.centerIn?
                anchors.fill = val.fill if val.fill?
                anchors.fillWidth = val.fillWidth if val.fillWidth?
                anchors.fillHeight = val.fillHeight if val.fillHeight?
                _super.call @, val
                return

        constructor: (ref) ->
            super ref
            @_top = null
            @_bottom = null
            @_verticalCenter = null
            @_left = null
            @_right = null
            @_horizontalCenter = null
            @_centerIn = null
            @_fill = null
            @_fillWidth = null
            @_fillHeight = null
            @_autoX = false
            @_autoY = false

            Object.preventExtensions @

        implMethod = Impl["set#{ctor.name}Anchor"]
        stringValuesCache = Object.create null
        createAnchorProp = (type, opts=0, getter) ->
            setter = (_super) -> (val=null) ->
                if typeof val is 'string'
                    unless arr = stringValuesCache[val]
                        arr = stringValuesCache[val] = val.split '.'
                    val = arr

                if val?
                    `//<development>`
                    allowedLines = if H_LINES[type] then H_LINES else V_LINES

                    unless Array.isArray(val) and val.length > 0 and val.length < 3
                        log.error "`anchors.#{type}` expects an array; `'#{val}'` given"

                    [target, line] = val

                    if opts & ONLY_TARGET_ALLOW
                        unless line is undefined
                            log.error "`anchors.#{type}` expects only a target to be defined; " +
                              "`'#{val}'` given;\npointing to the line is not required " +
                              "(e.g `anchors.centerIn = parent`)"

                    if opts & LINE_REQ
                        unless H_LINES[line] or V_LINES[line]
                            log.error "`anchors.#{type}` expects an anchor line to be defined; " +
                              "`'#{val}'` given;\nuse one of the `#{Object.keys allowedLines}`"

                    if opts & H_LINE_REQ
                        unless H_LINES[line]
                            log.error "`anchors.#{type}` can't be anchored to the vertical edge; " +
                              "`'#{val}'` given;\nuse one of the `#{Object.keys H_LINES}`"

                    if opts & V_LINE_REQ
                        unless V_LINES[line]
                            log.error "`anchors.#{type}` can't be anchored to the horizontal edge; " +
                              "`'#{val}'` given;\nuse one of the `#{Object.keys V_LINES}`"
                    `//</development>`

                    if val[0] is 'this'
                        val[0] = @

                if opts & FREE_V_LINE_REQ
                    @_autoX = !!val
                if opts & FREE_H_LINE_REQ
                    @_autoY = !!val

                _super.call @, val

            itemUtils.defineProperty
                constructor: Anchors
                name: type
                defaultValue: null
                implementation: (val) ->
                    implMethod.call @, type, val
                namespace: 'anchors'
                parentConstructor: ctor
                setter: setter
                getter: -> getter

        createAnchorProp 'left', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ, ->
            if @_ref
                @_ref.x - (@_ref._margin?._left or 0)

        createAnchorProp 'right', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ, ->
            if @_ref
                @_ref._x + @_ref._width + (@_ref._margin?._right or 0)

        createAnchorProp 'horizontalCenter', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ, ->
            if @_ref
                @_ref._x + @_ref._width / 2

        createAnchorProp 'top', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ, ->
            if @_ref
                @_ref._y - (@_ref._margin?._top or 0)

        createAnchorProp 'bottom', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ, ->
            if @_ref
                @_ref._y + @_ref._height + (@_ref._margin?._bottom or 0)

        createAnchorProp 'verticalCenter', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ, ->
            if @_ref
                @_ref._y + @_ref._height / 2

        createAnchorProp 'centerIn', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ, ->
            if @_ref
                [@horizontalCenter, @verticalCenter]

        createAnchorProp 'fill', ONLY_TARGET_ALLOW, ->
            if @_ref
                [@_ref._x, @_ref._y, @_ref._width, @_ref._height]

        createAnchorProp 'fillWidth', ONLY_TARGET_ALLOW, ->
            if @_ref
                [@_ref._x, @_ref._width]

        createAnchorProp 'fillHeight', ONLY_TARGET_ALLOW, ->
            if @_ref
                [@_ref._y, @_ref._height]
