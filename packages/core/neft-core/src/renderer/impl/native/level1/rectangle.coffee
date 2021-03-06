'use strict'

module.exports = (impl) ->
    {bridge} = impl
    {outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

    colorUtils = require '../../../utils/color'

    DATA = {}

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        if data.id is -1
            pushAction outActions.CREATE_RECTANGLE
            data.id = bridge.getId @

        impl.Types.Item.create.call @, data
        return

    setRectangleColor: (val) ->
        pushAction outActions.SET_RECTANGLE_COLOR
        pushItem @
        pushInteger colorUtils.toRGBAHex(val)
        return

    setRectangleRadius: (val) ->
        pushAction outActions.SET_RECTANGLE_RADIUS
        pushItem @
        pushFloat val
        return

    setRectangleBorderColor: (val) ->
        pushAction outActions.SET_RECTANGLE_BORDER_COLOR
        pushItem @
        pushInteger colorUtils.toRGBAHex(val)
        return

    setRectangleBorderWidth: (val) ->
        pushAction outActions.SET_RECTANGLE_BORDER_WIDTH
        pushItem @
        pushFloat val
        return
