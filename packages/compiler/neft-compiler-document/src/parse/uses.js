const { Element } = require('@neft/core')

module.exports = (element, parser) => {
  const nUses = []

  const forChild = (child) => {
    if (!(child instanceof Element.Tag)) return
    const { name } = child

    if (parser.components.has(name)) {
      // short syntax
      child.props['n-component'] = name
      nUses.push(child)
    } else if (parser.defaultComponentsByName[name]) {
      // default component
      child.props['n-component'] = name
      nUses.push(child)
    } else if (child.name === 'n-use') {
      // long formula
      nUses.push(child)
      child.name = 'blank'
    }

    child.children.forEach(forChild)
  }

  forChild(element)

  if (nUses.length) {
    parser.addProp('uses', () => JSON.stringify(nUses.map(nUse => nUse.getAccessPath(element))))
  }
}
