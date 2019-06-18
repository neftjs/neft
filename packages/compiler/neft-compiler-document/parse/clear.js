const { Element } = require('@neft/core')

const { Tag, Text } = Element

const checkNode = function (node) {
  if (node instanceof Text) {
    if (node.text.indexOf('\n') === -1) {
      return
    }
    node.text = node.text.replace(/^\s+$/gm, '')
    node.text = node.text.replace(/^[\n\r]|[\n\r]$/g, '')
    const minIndent = Math.min(...node.text.match(/^( *)/gm).map(str => str.length))
    if (minIndent > 0) {
      node.text = node.text.replace(new RegExp(`^ {${minIndent}}`, 'gm'), '')
    }
    if (node.text.length === 0) {
      node.parent = null
    }
  }

  if (node instanceof Tag) {
    node.children.slice().forEach(checkNode)
  }
}

module.exports = checkNode
