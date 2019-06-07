'use strict'

module.exports = (impl) ->
    {Item} = impl.Types

    {round} = Math

    # TODO: browsers makes borders always visible even
    #       if the size is less than border width

    DATA =
        innerElem: null
        innerElemStyle: null

    div = do ->
        div = document.createElement 'div'
        div.setAttribute 'class', 'rect'
        div

    DATA: DATA

    createData: impl.utils.createDataCloner 'Item', DATA

    create: (data) ->
        Item.create.call @, data

        innerElem = data.innerElem = div.cloneNode(false)
        impl.utils.prependElement data.elem, innerElem
        data.innerElemStyle = innerElem.style

    setRectangleColor: (val) ->
        @_impl.innerElemStyle.backgroundColor = val

    setRectangleRadius: (val) ->
        val = round val
        @_impl.innerElemStyle.borderRadius = "#{val}px"

    setRectangleBorderColor: (val) ->
        @_impl.innerElemStyle.borderColor = val

    setRectangleBorderWidth: (val) ->
        val = round val
        @_impl.innerElemStyle.borderWidth = "#{val}px"
