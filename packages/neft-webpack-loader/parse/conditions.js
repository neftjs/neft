const getElseElement = (node) => {
  if (!node.nextSibling) return null
  if (!node.nextSibling.props) return null
  if (!node.nextSibling.props.has('n-else')) return null
  return node.nextSibling
}

module.exports = (element, parser) => {
  const elements = element.queryAll('[n-if]')
  if (!elements.length) return

  parser.addProp('conditions', () => {
    let conditions = ''
    elements.forEach((child) => {
      const elseElement = getElseElement(child)
      const elementPath = child.getAccessPath(element)
      const elseElementPath = elseElement ? elseElement.getAccessPath(element) : null
      conditions += `{element: ${JSON.stringify(elementPath)}, `
      conditions += `elseElement: ${JSON.stringify(elseElementPath)}}, `
    })
    return `[${conditions}]`
  })
}
