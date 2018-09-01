xhtmlParser = require 'not-so-smart-xhtml-parser'
utils = require 'src/utils'
log = require 'src/log'

log = log.scope 'Document'

class ParserError extends Error
    constructor: (@message, @xhtml, @line, @row) ->
        @name = 'ParserError'

module.exports = (Element) ->
    parse: (xhtml) ->
        head = new Element.Tag
        stack = []

        getLastElement = -> utils.last(stack)

        addElement = (element) ->
            lastElement = getLastElement() or head

            length = lastElement.children.push element
            element._parent = lastElement
            if element._previousSibling = (lastElement.children[length - 2] or null)
                element._previousSibling._nextSibling = element
            return

        xhtmlParser.parse xhtml,
            opentag: (name) ->
                tag = new Element.Tag
                tag.name = name
                addElement tag
                stack.push tag

            closetag: (name, line, row) ->
                element = getLastElement()
                if (element.name is '' or name isnt '') and element.name isnt name
                    throw new ParserError(
                        "Expected `#{element.name}` tag to be closed, but `#{name}` found",
                        xhtml,
                        line,
                        row)
                stack.pop()

            attribute: (name, value) ->
                element = getLastElement()
                element.props[name] = value

            text: (text) ->
                # omit texts with only tabs and new lines
                unless text.replace(/[\t\n]/gm, '')
                    return

                element = new Element.Text
                element._text = text

                addElement element

            comment: ->
            instruction: ->

        if stack.length > 0
            lines = xhtml.split '\n'
            maxLine = lines.length - 1
            maxRow = utils.last(lines).length
            throw new ParserError("Element #{stack[0].name} is not closed", xhtml, maxLine, maxRow)

        head
