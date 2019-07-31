/* eslint-disable import/no-dynamic-require */
/* eslint-disable global-require */
const { Asset } = require('parcel-bundler')
require('@neft/parcel-util')
const { logger } = require('@neft/core')
const { parseToAst, parseToCode } = require('@neft/compiler-document')

const defaultStyles = JSON.parse(process.env.NEFT_PARCEL_DEFAULT_STYLES || '[]')
const defaultComponents = JSON.parse(process.env.NEFT_PARCEL_DEFAULT_COMPONENTS || '[]')
const extensions = JSON.parse(process.env.NEFT_PARCEL_EXTENSIONS || '[]')

extensions.forEach((extension) => {
  try {
    require(extension.path)
  } catch (error) {
    logger.log('')
    logger.error(`Cannot initialize extension **${extension.name}**`)
    throw error
  }
})

class NeftAsset extends Asset {
  constructor(name, options) {
    super(name, options)
    this.type = 'js'
    this.scripts = {}
    this.styles = {}
  }

  parse(code) {
    return parseToAst(code)
  }

  generate() {
    const result = []
    const scripts = this.ast.queryAll('script')
    const styles = this.ast.queryAll('style')

    scripts.forEach((script) => {
      const nComponent = script.queryParents('n-component')
      let key = this.id
      if (nComponent) key += `#${nComponent.props.name}`
      if (key in this.scripts) return
      this.scripts[key] = result.length
      result.push({
        type: script.props.lang || 'js',
        value: script.stringifyChildren(),
        map: '',
      })
    })

    styles.forEach((style) => {
      const nComponent = style.queryParents('n-component')
      let key = this.id
      if (nComponent) key += `#${nComponent.props.name}`
      if (key in this.styles) return
      this.styles[key] = result.length
      result.push({
        type: 'nml',
        value: style.stringifyChildren(),
        map: '',
      })
    })

    return result
  }

  postProcess(generated) {
    const scripts = { ...this.scripts }
    const styles = { ...this.styles }

    Object.entries(scripts).forEach(([key, index]) => {
      scripts[key] = generated[index]
    })

    Object.entries(styles).forEach(([key, index]) => {
      styles[key] = generated[index]
    })

    const { code, dependencies } = parseToCode(this.ast, {
      defaultStyles,
      defaultComponents,
      resourcePath: this.id,
      scripts,
      styles,
    })

    if (this.options.bundleNodeModules) {
      this.addDependency('@neft/core')
      defaultStyles.forEach(({ path }) => { this.addDependency(path) })
      defaultComponents.forEach(({ path }) => { this.addDependency(path) })
    }
    dependencies.forEach((name) => { this.addDependency(name) })

    return [{
      type: 'js',
      map: scripts.length > 0 ? scripts[0].map : null,
      value: code,
    }]
  }
}

module.exports = NeftAsset
