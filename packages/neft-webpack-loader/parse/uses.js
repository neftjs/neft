const Element = require('@neft/core/src/document/element')

module.exports = (element, parser) => {
  const nUses = []

  const forChild = (child) => {
    if (!(child instanceof Element.Tag)) return
    child.children.forEach(forChild)
    const { name } = child

    // change short syntax to long formula
    if (name.length > 0 && name[0].toUpperCase() === name[0]) {
      child.name = 'n-use'
      child.props['n-component'] = name
    }

    // get uses
    if (child.name === 'n-use') {
      child.name = ''
      nUses.push(child)
    }
  }

  forChild(element)

  if (nUses.length) {
    parser.addProp('uses', () => JSON.stringify(nUses.map(nUse => nUse.getAccessPath(element))))
  }
}
