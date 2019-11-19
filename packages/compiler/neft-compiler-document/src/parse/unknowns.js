const { Element: { Tag } } = require('@neft/core')

const KNOWN_TAGS = new Set(['n-provide-context'])

module.exports = (element, parser) => {
  const forElement = (child) => {
    if (!(child instanceof Tag)) return
    if (child.name.startsWith('n-') && child.visible && !KNOWN_TAGS.has(child.name)) {
      parser.error(new Error(`Unknown tag ${child.name}`))
    }
    child.children.forEach(forElement)
  }

  forElement(element)
}
