const { Element: { Tag } } = require('@neft/core')

module.exports = (element, parser) => {
  const forElement = (child) => {
    if (!(child instanceof Tag)) return
    if (child.name.startsWith('n-') && child.visible) {
      parser.error(new Error(`Unknown tag ${child.name}`))
    }
    child.children.forEach(forElement)
  }

  forElement(element)
}
