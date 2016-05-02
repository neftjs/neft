'use strict'

utils = require 'src/utils'

module.exports = (impl) ->
    {grid} = impl.utils

    DATA: grid.DATA

    createData: impl.utils.createDataCloner 'Item', grid.DATA

    create: (data) ->
        impl.Types.Item.create.call @, data

        grid.create @, grid.COLUMN | grid.ROW

    setGridEffectItem: grid.setEffectItem
    setGridColumns: grid.update
    setGridRows: grid.update
    setGridColumnSpacing: grid.update
    setGridRowSpacing: grid.update
    setGridAlignmentHorizontal: grid.update
    setGridAlignmentVertical: grid.update
    setGridIncludeBorderMargins: grid.update
