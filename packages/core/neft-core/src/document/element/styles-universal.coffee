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
        return

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
        return

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
                if docStyle.hasText
                    docStyle.updateText()
                break
            node = node.parent
        return

    (element, val) ->
        setVisibleForNode element, val
        updateTextNode element
        return

exports.onSetText = do ->
    updateTextNode = (node) ->
        while node
            docStyle = node._documentStyle
            if docStyle?.hasText
                docStyle.updateText()
                break
            node = node.parent
        return

    (element) ->
        updateTextNode element
        return

exports.onSetProp = (element, name, val, oldVal) ->
    docStyle = element._documentStyle
    return unless docStyle

    # update style props
    docStyle.setProp name, val, oldVal
    return
