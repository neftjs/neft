/* eslint-disable no-console */
const parseXHTML = require('./xhtml-parser')

/* eslint-disable global-require */
const PARSERS = [
  require('./parse/clear'),
  require('./parse/components'),
  require('./parse/styles'),
  require('./parse/iterators'),
  require('./parse/scripts'),
  require('./parse/props'),
  require('./parse/conditions'),
  require('./parse/uses'),
  require('./parse/storage'),
  require('./parse/refs'),
  require('./parse/logs'),
  require('./parse/calls'),
  require('./parse/slot'),
  require('./parse/unknowns'),
]
/* eslint-enable global-require */

const props = Symbol('props')
const propsToAdd = Symbol('propsToAdd')

class ComponentParser {
  constructor({
    scripts, styles, resourcePath, defaultStyles, defaultComponents, components,
  }) {
    this.error = console.error
    this.warning = console.warn
    this.scripts = scripts
    this.styles = styles
    this.resourcePath = resourcePath
    this.defaultStyles = defaultStyles
    this.defaultComponents = defaultComponents
    this.defaultComponentsByName = defaultComponents.reduce((target, { name, ...rest }) => ({
      ...target,
      [name]: rest,
    }), {})
    this.components = new Set(components)
    this.dependencies = []
    this[props] = {}
    this[propsToAdd] = {}
  }

  addProp(name, generator) {
    this[propsToAdd][name] = generator
  }

  propsToCode() {
    let result = '{\n'
    Object.keys(this[props]).forEach((key) => {
      result += `${key}: ${this[props][key]},\n`
    })
    result += '}'
    return result
  }

  parseComponentElement(element, options) {
    const componentCode = new ComponentParser({ ...this, ...options }).toCode(element)
    return componentCode.exports
  }

  toCode(element) {
    PARSERS.forEach(parser => parser(element, this))
    this.addProp('element', () => `Element.fromJSON(${JSON.stringify(element)})`)
    Object.keys(this[propsToAdd]).forEach((key) => { this[props][key] = this[propsToAdd][key]() })
    return {
      exports: `(options) => new Document('${this.resourcePath}', ${this.propsToCode()}, options)`,
      dependencies: this.dependencies,
    }
  }
}

const parseComponent = (parser, ast) => {
  const documentCode = parser.toCode(ast)
  const dependencies = parser.dependencies.map(src => `require('${src}')`)
  const code = `const { Document, Element } = require('@neft/core')
Document.register('${parser.resourcePath}', ${documentCode.exports}, {
  dependencies: [${dependencies}],
})
module.exports = '${parser.resourcePath}'
if (module.hot) {
  module.hot.accept(() => {
    Document.reload('${parser.resourcePath}')
  })
}
`
  return {
    code,
    dependencies: documentCode.dependencies,
  }
}

exports.parseToAst = parseXHTML

exports.parseToCode = (ast, {
  resourcePath,
  scripts,
  styles,
  defaultStyles = [],
  defaultComponents = [],
} = {}) => {
  const parser = new ComponentParser({
    resourcePath,
    scripts,
    styles,
    defaultStyles,
    defaultComponents,
  })

  return parseComponent(parser, ast)
}
