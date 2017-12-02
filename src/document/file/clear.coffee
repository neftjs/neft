'use strict'

module.exports = (File) ->
    {Element} = File
    {Tag, Text} = Element

    checkNode = (node) ->
        if node instanceof Text
            # skip single line texts
            if node.text.indexOf('\n') is -1
                return

            # remove lines with only white spaces
            node.text = node.text.replace /^\s+$/gm, ''

            # remove new lines from the start and end of the text
            node.text = node.text.replace /^[\n\r]|[\n\r]$/g, ''

            # remove indentation
            minIndent = Math.min node.text.match(/^( *)/gm).map((str) -> str.length)...
            if minIndent > 0
                node.text = node.text.replace new RegExp("^ {#{minIndent}}", 'gm'), ''

            # remove empty texts
            if node.text.length is 0
                node.parent = null

        # check nodes recursively
        if node instanceof Tag
            for child in node.children by -1
                checkNode child

        return
