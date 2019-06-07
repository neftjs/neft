const findImports = (element, parser) => {
  const imports = []
  element.queryAll('n-import').forEach((child) => {
    const { src, as } = child.props
    child.parent = null
    if (!src || !as) {
      parser.warning(new Error('<n-import> must provide src="" and as="" properties'))
      return
    }
    imports.push({ src, name: as })
  })
  return imports
}

module.exports = function (element, parser) {
  let components = ''

  // merge components from files
  const links = findImports(element, parser)
  links.forEach((link) => {
    components += `"${link.name}": require('${link.src}'),`
  })

  // find components in file
  element.queryAll('n-component').forEach((child) => {
    const { name } = child.props
    if (!name) return
    if (child.queryParents('n-component')) return

    child.name = ''
    child.parent = null
    components += `"${name}": ${parser.parseComponentElement(child)}, `
  })

  // add prop
  if (components.length) parser.addProp('components', () => `{${components}}`)

  // reload for development
  if (links.length > 0) {
    const linkSources = links.map(link => link.src)
    parser.addFooterCode(`if (process.env.NODE_ENV === 'development') {
  if (module.hot) {
    module.hot.accept(${JSON.stringify(linkSources)}, () => {
      Document.reload('${parser.resourcePath}', { components: {${components}} })
    })
  }
}`)
  }
}
