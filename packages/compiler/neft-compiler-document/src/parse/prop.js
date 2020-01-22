module.exports = (element, parser) => {
  const nProps = element.queryAll('n-prop')
  const props = {}

  nProps.forEach((nProp) => {
    const { name } = nProp.props
    if (!name) {
      parser.warning(new Error('<n-prop /> needs to define a name'))
    }
    if (props[name]) {
      parser.warning(new Error('<n-prop /> name is duplicated'))
    }
    nProp.parent = null
    props[name] = true
  })

  parser.addProp('props', () => JSON.stringify(props))
}
