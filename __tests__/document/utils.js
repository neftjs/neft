const fs = require('fs')
const path = require('path')
const slash = require('slash')
const loader = require('@neft/webpack-loader')

const createLocalRequire = files => (filepath) => {
  const key = slash(filepath)
  if (!(key in files)) {
    throw new Error(`Cannot find ${key} in ${Object.keys(files)}`)
  }
  const module = files[key]
  return module
}

const requireNmlFile = (filepath) => {
  const localRequires = {
    '@neft/core/src/renderer': require('@neft/core/src/renderer'),
    './img-tag': require('@neft/default-styles/img-tag'),
  }
  const localRequire = createLocalRequire(localRequires)

  const body = loader.call({
    resourcePath: require.resolve(filepath),
  }, fs.readFileSync(require.resolve(filepath), 'utf-8'))

  const module = {}
  new Function('module', 'require', body)(module, localRequire)
  return module.exports
}

const localRequires = {
  '@neft/core/src/document': require('@neft/core/src/document'),
  '@neft/core/src/document/element': require('@neft/core/src/document/element'),
  '@neft/core/src/renderer': require('@neft/core/src/renderer'),
  '@neft/default-styles/index.nml': requireNmlFile('@neft/default-styles/index.nml'),
}

const localRequire = createLocalRequire(localRequires)

exports.createView = (html) => {
  const module = {}
  const viewFuncBody = loader.call({
    fs,
    resourcePath: 'test.xhtml',
    emitError: () => {},
    emitWarning: () => {},
    query: {
      defaultStyles: ['@neft/default-styles'],
    },
    context: path.join(__dirname, '../'),
  }, html)
  new Function('module', 'require', viewFuncBody)(module, localRequire)
  return module.exports()
}

exports.renderParse = (view, opts) => {
  view.render(opts)
  view.revert()
  view.render(opts)
}

exports.createViewAndRender = (html, opts) => {
  const view = exports.createView(html)
  exports.renderParse(view, opts)
  return view
}
