'use strict'

module.exports = (impl) ->
    {items} = impl

    DATA = {}

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        impl.Types.Item.create.call @, data

    updateNativeSize: ->
        {setPropertyValue} = impl.Renderer.itemUtils
        {elem} = @_impl
        if @_autoWidth
            setPropertyValue @, 'width', elem.offsetWidth
            @_autoWidth = true
        if @_autoHeight
            setPropertyValue @, 'height', elem.offsetHeight
            @_autoHeight = true
        return
