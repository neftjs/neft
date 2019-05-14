const { Tag } = require('@neftio/core/src/document/element')

module.exports = (element, parser) => {
  const forElement = (child) => {
    if (!(child instanceof Tag)) return
    if (child.name.startsWith('n-')) parser.error(new Error(`Unknown tag ${child.name}`))
    child.children.forEach(forElement)
  }

  forElement(element)
}
