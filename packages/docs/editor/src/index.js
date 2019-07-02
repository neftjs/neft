/* eslint-env browser */
/* global Babel */

const fs = require('fs')
const { util } = require('@neft/core')
const { parseToAst, parseToCode } = require('@neft/compiler-document')
const { bundle: parseNml } = require('@neft/compiler-style')
require('@neft/input')

const DEFAULT_STYLES = [
  {
    name: '@neft/default-styles',
    file: fs.readFileSync('../../ui/neft-default-styles/style.nml', 'utf-8'),
  },
  {
    name: '@neft/button',
    file: fs.readFileSync('../../ui/neft-button/style.nml', 'utf-8'),
  },
  {
    name: '@neft/input',
    file: fs.readFileSync('../../ui/neft-input/style.nml', 'utf-8'),
  },
].map(({ name, file }) => {
  const { queries } = parseNml(file, { resourcePath: name })
  return { name, queries, path: `${name}/style.nml` }
})

window.NeftEditor = {
  compile(html) {
    const ast = parseToAst(html)
    const resourcePath = `editor-${util.uid()}.neft`

    const scripts = {}
    ast.queryAll('script').forEach((script) => {
      const nComponent = script.queryParents('n-component')
      let key = resourcePath
      if (nComponent) key += `#${nComponent.props.name}`
      if (key in scripts) return
      let value = script.stringifyChildren()
      value = Babel.transform(value, { presets: ['es2015'] }).code
      scripts[key] = { value }
    })

    const styles = {}
    ast.queryAll('style').forEach((style) => {
      const nComponent = style.queryParents('n-component')
      let key = resourcePath
      if (nComponent) key += `#${nComponent.props.name}`
      if (key in styles) return
      let value = style.stringifyChildren()
      const bundled = parseNml(value, { resourcePath })
      value = bundled.bundle
      value = `module.exports = (() => { ${value} })()`
      value = Babel.transform(value, { presets: ['es2015'] }).code
      styles[key] = { value, queries: bundled.queries }
    })

    const { code } = parseToCode(ast, {
      defaultStyles: DEFAULT_STYLES,
      resourcePath,
      scripts,
      styles,
    })

    return code
  },
}
