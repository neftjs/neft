'use strict'

assert = require '../../../../assert'
utils = require '../../../../util'

module.exports = (Renderer, Impl, itemUtils) -> (ctor) -> class Spacing extends itemUtils.DeepObject
    @__name__ = 'Spacing'

    itemUtils.defineProperty
        constructor: ctor
        name: 'spacing'
        defaultValue: 0
        valueConstructor: Spacing
        setter: (_super) -> (val) ->
            {spacing} = @
            if utils.isObject(val)
                spacing.column = val.column if val.column?
                spacing.row = val.row if val.row?
            else
                spacing.column = spacing.row = val
            _super.call @, val
            return

    constructor: (ref) ->
        super ref
        @_column = 0
        @_row = 0

        Object.preventExtensions @

    itemUtils.defineProperty
        constructor: @
        name: 'column'
        defaultValue: 0
        namespace: 'spacing'
        parentConstructor: ctor
        implementation: Impl["set#{ctor.name}ColumnSpacing"]
        developmentSetter: (val) ->
            assert.isFloat val

    itemUtils.defineProperty
        constructor: @
        name: 'row'
        defaultValue: 0
        namespace: 'spacing'
        parentConstructor: ctor
        implementation: Impl["set#{ctor.name}RowSpacing"]
        developmentSetter: (val) ->
            assert.isFloat val

    valueOf: ->
        if @column is @row
            @column
        else
            throw new Error "column and row spacing are different"

    toJSON: ->
        column: @column
        row: @row
