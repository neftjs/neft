const { Asset } = require('parcel-bundler')
const coffee = require('coffee-script')
const path = require('path')

class CoffeeScriptAsset extends Asset {
  constructor(name, options) {
    super(name, options)
    this.type = 'js'
    this.cacheData.env = {}
  }

  shouldInvalidate(cacheData) {
    // eslint-disable-next-line no-restricted-syntax
    for (const key in cacheData.env) {
      if (cacheData.env[key] !== process.env[key]) {
        return true
      }
    }

    return false
  }

  async generate() {
    const extname = path.extname(this.name)
    const literate = extname === '.litcoffee' || extname === '.coffee.md'
    const transpiled = coffee.compile(this.contents, {
      literate,
      sourceMap: this.options.sourceMaps,
    })

    let sourceMap
    if (transpiled.sourceMap) {
      sourceMap = transpiled.sourceMap.generate()
      sourceMap.sources = [this.relativeName]
      sourceMap.sourcesContent = [this.contents]
    }

    return [{
      type: 'js',
      value: this.options.sourceMaps ? transpiled.js : transpiled,
      sourceMap,
    }]
  }
}

module.exports = CoffeeScriptAsset
