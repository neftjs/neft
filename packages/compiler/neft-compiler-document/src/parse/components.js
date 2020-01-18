const { Element } = require('@neft/core')

const findImports = (element, parser) => {
  const imports = []
  element.queryAll('n-import').forEach((child) => {
    const { src } = child.props
    let { as: name } = child.props
    child.parent = null
    if (!src) {
      parser.warning(new Error('<n-import> must provide src="" property'))
      return
    }
    if (!name) {
      // eslint-disable-next-line prefer-destructuring
      name = (/\/([^/]+?)(\.[a-zA-Z]+?)?$/.exec(src) || [])[1]
    }
    imports.push({ src, name })
  })
  return imports
}

module.exports = function (element, parser) {
  const imports = {}
  const components = {}

  // find components in file
  element.queryAll('n-component').forEach((child) => {
    const { name } = child.props
    if (!name) return
    if (child.queryParents('n-component')) return

    child.parent = null
    const container = new Element.Tag()
    while (child.children.length > 0) {
      child.children[0].parent = container
    }

    const options = {
      resourcePath: `${parser.resourcePath}#${name}`,
    }
    components[name] = { child: container, options }
    parser.components.add(name)
    parser.localComponents.add(name)
  })

  // add imports
  const links = findImports(element, parser)
  links.forEach(({ name, src }) => {
    if (parser.components.has(name)) return
    parser.dependencies.push(src)
    parser.components.add(name)
    parser.localComponents.add(name)
    imports[name] = src
  })

  // add default components
  parser.defaultComponents.forEach(({ name, path: compPath }) => {
    if (parser.components.has(name)) return
    parser.components.add(name)
    imports[name] = compPath
  })

  // stringify imports
  if (Object.keys(imports).length) {
    let importsText = ''
    Object.entries(imports).forEach(([name, src]) => {
      importsText += `"${name}": require('${src}'),`
    })
    parser.addProp('imports', () => `{${importsText}}`)
  }

  // stringify components
  if (Object.keys(components).length) {
    let componentsText = ''
    Object.entries(components).forEach(([name, { child, options }]) => {
      componentsText += `"${name}": ${parser.parseComponentElement(child, options)}, `
    })
    parser.addProp('components', () => `{${componentsText}}`)
  }
}
