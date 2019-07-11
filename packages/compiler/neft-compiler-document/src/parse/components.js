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
  let imports = ''
  let components = ''

  // merge components from files
  const links = findImports(element, parser)
  links.forEach((link) => {
    parser.dependencies.push(link.src)
    imports += `"${link.name}": require('${link.src}'),`
  })

  if (imports.length) parser.addProp('imports', () => `{${imports}}`)

  // find components in file
  element.queryAll('n-component').forEach((child) => {
    const { name } = child.props
    if (!name) return
    if (child.queryParents('n-component')) return

    child.name = ''
    child.parent = null
    const options = {
      resourcePath: `${parser.resourcePath}#${name}`,
    }
    components += `"${name}": ${parser.parseComponentElement(child, options)}, `
  })

  if (components.length) parser.addProp('components', () => `{${components}}`)
}
