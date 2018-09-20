const fs = require('fs')
const loader = require('@neft/webpack-loader')

const requireNmlFile = (filepath) => {
  const localRequires = {
    '@neft/core/src/renderer': require('@neft/core/src/renderer'),
  }
  const localRequire = path => localRequires[path]

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

const localRequire = path => localRequires[path]

exports.createView = (html) => {
  const module = {}
  const viewFuncBody = loader.call({
    fs,
    resourcePath: 'text.xhtml',
    emitError: () => {},
    emitWarning: () => {},
    query: {
      defaultStyles: ['@neft/default-styles'],
    },
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
