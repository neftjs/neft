const Element = require('@neftio/core/src/document/element')

const parseNForSyntax = (nFor) => {
  if (!nFor.includes(' in ')) return null
  const inParts = nFor.split(' in ')
  let left = inParts[0]
  if (left[0] === '(' && left[left.length - 1] === ')') {
    left = left.slice(1, -1)
  }

  // set binding scope
  const parts = left.split(',').map(part => part.trim())

  return {
    item: parts[0] || '',
    index: parts[1] || '',
    array: parts[2] || '',
    binding: inParts[1],
  }
}

module.exports = (element, parser) => {
  const iterators = []

  element.queryAll('[n-for]').forEach((forElem) => {
    if (forElem.queryParents('[n-for]')) return
    const nFor = forElem.props['n-for']
    if (typeof nFor !== 'string') return
    const container = new Element.Tag()
    forElem.children.forEach((child) => { child.parent = container })
    const forComponent = parser.parseComponentElement(container, { defaultStyles: [] })
    const syntax = parseNForSyntax(nFor)
    if (!syntax) parser.error(new Error(`Invalid syntax of \`n-for="${forElem.props['n-for']}"\``))
    forElem.props['n-for'] = syntax.binding
    iterators.push({ forElem, forComponent, syntax })
  })

  if (iterators.length) {
    parser.addProp('iterators', () => {
      let code = ''
      iterators.forEach(({ forElem, forComponent, syntax }) => {
        code += `{ element: ${JSON.stringify(forElem.getAccessPath(element))}, \
component: ${forComponent}, naming: ${JSON.stringify(syntax)} \
}, `
      })
      return `[${code}]`
    })
  }
}
