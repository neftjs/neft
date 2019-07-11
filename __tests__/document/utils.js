/* eslint-disable import/no-dynamic-require */
/* eslint-disable global-require */
/* eslint-disable no-new-func */
const fs = require('fs')
const path = require('path')
const styleCompiler = require('@neft/compiler-style')

// we can't use require.extensions inside jest so we're going to mock 'require'
// for the compiled .neft file
let defaultStyles
process.env.NEFT_PARCEL_DEFAULT_STYLES = JSON.stringify((() => {
  const indexNml = path.join(require.resolve('@neft/default-styles'), '../../style.nml')
  const file = fs.readFileSync(indexNml, 'utf-8')
  const bundle = styleCompiler.bundle(file, {
    resourcePath: '@neft/default-styles',
  })

  defaultStyles = new Function('module', 'require', bundle.bundle)(module, (src) => {
    return require(require.resolve(src, { paths: [ path.dirname(indexNml) ] }))
  })

  return [{
    name: '@neft/default-styles',
    path: path.join('@neft/default-styles', '/style.nml'),
    queries: bundle.queries,
  }]
})())

const NeftAsset = require('@neft/parcel-plugin-neft/NeftAsset')
const NmlAsset = require('@neft/parcel-plugin-nml/NmlAsset')
const { Document } = require('@neft/core')

exports.createView = (html) => {
  const asset = new NeftAsset('test.neft', { rootDir: '' })
  asset.id = 'test.neft'
  asset.ast = asset.parse(html)
  let generated = asset.generate()
  generated = generated.map(({ type, value }) => {
    if (type === 'nml') {
      const nmlAsset = new NmlAsset('test.nml', { rootDir: '' })
      nmlAsset.id = 'test.nml'
      nmlAsset.contents = value
      const nmlGenerated = nmlAsset.generate()
      return nmlAsset.postProcess(nmlGenerated)[0]
    }
    return { type, value }
  })
  const [{ value }] = asset.postProcess(generated)

  const module = {}
  new Function('module', 'require', value)(module, (src) => {
    if (src === '@neft/default-styles/style.nml') return defaultStyles
    return require(src)
  })
  return Document.getComponentConstructorOf(module.exports)()
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
