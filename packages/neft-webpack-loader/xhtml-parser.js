const xhtmlParser = require('not-so-smart-xhtml-parser')
const util = require('@neft/core/src/util/index.litcoffee')
const Element = require('@neft/core/src/document/element')

class ParserError extends Error {
  constructor(message, xhtml, line, row) {
    super(message)
    this.message = message
    this.xhtml = xhtml
    this.line = line
    this.row = row
    this.name = 'ParserError'
  }
}

module.exports = (xhtml) => {
  const head = new Element.Tag()
  const stack = []
  const getLastElement = () => util.last(stack)
  const addElement = (element) => {
    const lastElement = getLastElement() || head
    element.parent = lastElement
  }
  xhtmlParser.parse(xhtml, {
    opentag(name) {
      const tag = new Element.Tag()
      tag.name = name
      addElement(tag)
      return stack.push(tag)
    },
    closetag(name, line, row) {
      const element = getLastElement()
      if ((element.name === '' || name !== '') && element.name !== name) {
        throw new ParserError(`Expected \`${element.name}\` tag to be closed, but \`${name}\` found`, xhtml, line, row)
      }
      return stack.pop()
    },
    attribute(name, value) {
      const element = getLastElement()
      element.props[name] = value
    },
    text(text) {
      if (!text.replace(/[\t\n]/gm, '')) {
        return
      }
      const element = new Element.Text()
      element.text = text
      addElement(element)
    },
    comment() {},
    instruction() {},
  })

  if (stack.length > 0) {
    const lines = xhtml.split('\n')
    const maxLine = lines.length - 1
    const maxRow = util.last(lines).length
    throw new ParserError(`Element ${stack[0].name} is not closed`, xhtml, maxLine, maxRow)
  }

  return head
}
