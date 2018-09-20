const path = require('path')
const nodeFs = require('fs')
const parseXHTML = require('./xhtml-parser')
const nmlParser = require('./nml-parser')

/* eslint-disable global-require */
const PARSERS = [
  require('./parse/clear'),
  require('./parse/components'),
  require('./parse/styles'),
  require('./parse/iterators'),
  require('./parse/scripts'),
  require('./parse/props'),
  require('./parse/target'),
  require('./parse/uses'),
  require('./parse/storage'),
  require('./parse/conditions'),
  require('./parse/refs'),
  require('./parse/logs'),
]
/* eslint-enable global-require */

const realpath = nodeFs.realpathSync('.')

const props = Symbol('props')
const propsToAdd = Symbol('propsToAdd')

class ComponentParser {
  constructor({
    fs, error, warning, resourcePath, defaultStyles,
  }) {
    this.fs = fs
    this.error = error
    this.warning = warning
    this.resourcePath = path.relative(realpath, resourcePath)
    this.defaultStyles = defaultStyles
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
    return new ComponentParser({ ...this, ...options }).toCode(element)
  }

  toCode(element) {
    PARSERS.forEach(parser => parser(element, this))
    this.addProp('element', () => `Element.fromJSON(${JSON.stringify(element)})`)
    Object.keys(this[propsToAdd]).forEach((key) => { this[props][key] = this[propsToAdd][key]() })
    return `(options) => new Document('${this.resourcePath}', Object.assign(${this.propsToCode()}, options))`
  }
}

const parseNML = (parser, code) => {
  const { bundle } = nmlParser.bundle(code, parser)
  return `module.exports = (() => { ${bundle} })()`
}

const parseComponent = (parser, code) => {
  const documentCode = parser.toCode(parseXHTML(code))
  return `const Document = require('@neft/core/src/document')
const Element = require('@neft/core/src/document/element')
module.exports = ${documentCode}`
}

module.exports = function (code) {
  const defaultStyles = (this.query && this.query.defaultStyles) || []
  const parser = new ComponentParser({
    fs: this.fs,
    error: this.emitError,
    warning: this.emitWarning,
    resourcePath: this.resourcePath,
    defaultStyles,
  })

  if (path.extname(this.resourcePath) === '.nml') {
    return parseNML(parser, code)
  }
  return parseComponent(parser, code)
}
