const Element = require('@neft/core/src/document/element')

module.exports = (element, parser) => {
  const nUses = []

  const forChild = (child) => {
    if (!(child instanceof Element.Tag)) return
    child.children.forEach(forChild)
    const { name } = child

    // short syntax
    if (name.length > 0 && name[0].toUpperCase() === name[0]) {
      child.props['n-component'] = name
      nUses.push(child)
    }

    // long formula
    if (child.name === 'n-use') {
      nUses.push(child)
      child.name = 'blank'
    }
  }

  forChild(element)

  if (nUses.length) {
    parser.addProp('uses', () => JSON.stringify(nUses.map(nUse => nUse.getAccessPath(element))))
  }
}
