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
        elem = @_impl.innerElem or @_impl.elem

        if (@_autoWidth or @_autoHeight) and not elem.offsetParent
            elemNextSibling = elem.nextSibling
            elemParent = elem.parentNode
            impl._hatchery.appendChild elem

        if @_autoWidth
            setPropertyValue @, 'width', elem.offsetWidth
        if @_autoHeight
            setPropertyValue @, 'height', elem.offsetHeight

        if elemNextSibling
            elemParent.insertBefore elem, elemNextSibling
        else if elemParent
            elemParent.appendChild elem
        return
