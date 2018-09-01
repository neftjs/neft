'use strict'

module.exports = (File) ->
    {Tag} = File.Element

    (file) ->
        {props} = file

        for child in file.node.children
            unless child instanceof Tag
                continue

            if child.name is 'n-props'
                for prop of child.props
                    props.push prop

        return
