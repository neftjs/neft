exports.onSetParent = do ->
    findItemParent = (node) ->
        tmp = node
        while tmp
            if (docStyle = tmp._documentStyle) and (item = docStyle.item)
                return item
            tmp = tmp.parent
        return null

    setItemParent = (node, newParent) ->
        if (docStyle = node._documentStyle)
            docStyle.setItemParent newParent
        else if node.children
            for child in node.children
                setItemParent child, newParent
        return

    (element, val) ->
        newParent = findItemParent val
        setItemParent element, newParent

exports.onSetIndex = do ->
    updateItemIndex = (node) ->
        if (docStyle = node._documentStyle)
            docStyle.findItemIndex()
        else if node.children
            for child in node.children
                updateItemIndex child
        return

    (element) ->
        updateItemIndex element

exports.onSetVisible = do ->
    setVisibleForNode = (node, val) ->
        if (docStyle = node._documentStyle)
            docStyle.setVisibility val
        else if node.children
            for child in node.children
                if child.visible
                    setVisibleForNode child, val
        return

    updateTextNode = (node) ->
        while node
            if (docStyle = node._documentStyle)
                if docStyle.textProp
                    docStyle.updateText()
                break
            node = node.parent
        return

    (element, val) ->
        setVisibleForNode element, val
        updateTextNode element

exports.onSetText = (element) ->
    element._documentStyle?.updateText()
    return

exports.onSetProp = (element, name, val, oldVal) ->
    docStyle = element._documentStyle
    return unless docStyle

    # update style props
    docStyle.setProp name, val, oldVal
