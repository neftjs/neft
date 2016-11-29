# Spacing

    'use strict'

    assert = require 'src/assert'
    utils = require 'src/utils'

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

## *Float* Spacing::column = `0`

## *Signal* Spacing::onColumnChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'column'
            defaultValue: 0
            namespace: 'spacing'
            parentConstructor: ctor
            implementation: Impl["set#{ctor.__name__}ColumnSpacing"]
            developmentSetter: (val) ->
                assert.isFloat val

## *Float* Spacing::row = `0`

## *Signal* Spacing::onRowChange(*Float* oldValue)

        itemUtils.defineProperty
            constructor: @
            name: 'row'
            defaultValue: 0
            namespace: 'spacing'
            parentConstructor: ctor
            implementation: Impl["set#{ctor.__name__}RowSpacing"]
            developmentSetter: (val) ->
                assert.isFloat val

## *Float* Spacing::valueOf()

        valueOf: ->
            if @column is @row
                @column
            else
                throw new Error "column and row spacing are different"

        toJSON: ->
            column: @column
            row: @row
