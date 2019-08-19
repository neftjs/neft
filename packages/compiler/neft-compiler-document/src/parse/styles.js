const { Element } = require('@neft/core')

const { Text, Tag } = Element

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
  if (isTag && element.name.slice(0, 2) !== 'n-') {
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
    const value = style.link ? `require('${style.href}')` : `((module) => {\n\n${style.bundle}\n\nreturn module.exports\n})({})`
    result += `'${style.name}': ${value}, `
  })
  result += ' }'
  return result
}

module.exports = (element, parser) => {
  const styles = []
  const queries = {}

  const addStyle = (name, nml, { link = false } = false) => {
    const styleQueries = {}
    Object.entries(nml.queries).forEach(([query, queryPath]) => {
      styleQueries[query] = [name, ...queryPath]
    })
    Object.assign(queries, styleQueries)
    styles.push({
      ...nml, name, href: nml.path, link,
    })
  }

  let bare = false
  const docStyle = element.query('style')
  if (docStyle) {
    docStyle.parent = null
    bare = !!docStyle.props.bare
  }

  if (!bare) {
    parser.defaultStyles
      .forEach((style) => { addStyle(style.name, style, { link: !!style.path }) })
  }
  if (docStyle) {
    const parserStyle = parser.styles[parser.resourcePath]
    addStyle('__default__', {
      bundle: parserStyle.value,
      queries: parserStyle.queries,
    })
  }
  if (styles.length) applyStyleQueriesInElement(element, queries, parser)

  parser.addProp('style', () => getStyleFiles(styles))

  parser.addProp('styleItems', () => {
    const definitions = findDefinitions(element, element)
    return JSON.stringify(definitions)
  })

  const nextStyles = element.queryAll('style')
  if (nextStyles.length > 0) {
    parser.warning(new Error('Component file can contain only one <style> tag'))

    nextStyles.forEach((nextStyle) => {
      nextStyle.parent = null
    })
  }
}
