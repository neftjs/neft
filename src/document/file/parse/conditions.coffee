'use strict'

module.exports = (File) ->
    {Condition} = File

    (file) ->
        {conditions} = file

        forEachNodeRec = (node) ->
            for child in node.children
                unless child instanceof File.Element.Tag
                    continue

                forEachNodeRec child

                if child.props.has('n-if')
                    elseNode = null
                    if child.nextSibling?.props?.has?('n-else')
                        elseNode = child.nextSibling

                    conditions.push new File.Condition file, child, elseNode
            return

        forEachNodeRec file.node
