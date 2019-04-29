const path = require('path')
const { Text, Tag } = require('@neftio/core/src/document/element')
const nmlParser = require('../nml-parser')

const applyStyleQueriesInElement = (rootElement, queries, parser) => {
  Object.keys(queries).forEach((query) => {
    const elements = rootElement.queryAll(query)
    elements.forEach((element) => {
      if (element instanceof Tag) {
        element.props.set('n-style', queries[query])
      } else {
        parser.warning(`Styles cannot be attached to texts; ${query} has been omitted`)
      }
    })
  })
}

const findDefinitions = (rootElement, element) => {
  const isTag = element instanceof Tag
  const isText = element instanceof Text
  const nStyle = isTag && element.props['n-style']

  const children = []
  if (isTag) {
    element.children.forEach((child) => {
      children.push(...findDefinitions(rootElement, child))
    })
  }

  if (isText || nStyle) {
    return [{
      element: element.getAccessPath(rootElement),
      children: isTag ? children : null,
    }]
  }

  return children
}

const getStyleFiles = (styles) => {
  let result = '{ '
  styles.forEach((style) => {
    const value = style.link ? `require('${style.href}')` : `(() => { ${style.bundle} })()`
    result += `'${style.name}': ${value}, `
  })
  result += ' }'
  return result
}

module.exports = (element, parser) => {
  const styles = []
  const queries = {}

  const getFileSync = (href) => {
    const filePath = require.resolve(href, { paths: [parser.context] })
    return String(parser.fs.readFileSync(filePath, 'utf-8'))
  }

  const parseNml = (href, text = getFileSync(href)) => nmlParser.bundle(text, parser)

  const addStyle = (name, text) => {
    const href = path.join(name, '/index.nml')
    const nml = parseNml(href, text)
    Object.values(nml.queries).forEach((queryPath) => { queryPath.unshift(name) })
    Object.assign(queries, nml.queries)
    styles.push({
      ...nml, name, href, link: text == null,
    })
  }

  let bare = false
  const docStyle = element.query('style')
  if (docStyle) {
    docStyle.parent = null
    bare = !!docStyle.props.bare
  }

  if (!bare) parser.defaultStyles.forEach((name) => { addStyle(name) })
  if (docStyle) addStyle('__default__', docStyle.stringifyChildren())
  if (styles.length) applyStyleQueriesInElement(element, queries, parser)

  parser.addProp('style', () => getStyleFiles(styles))

  parser.addProp('styleItems', () => {
    const definitions = findDefinitions(element, element)
    return JSON.stringify(definitions)
  })

  const nextStyle = element.query('style')
  if (nextStyle) {
    parser.warning(new Error('Component file can contain only one <style> tag'))
  }
}
