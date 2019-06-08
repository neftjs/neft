const { Asset } = require('parcel-bundler')
const coffee = require('coffee-script')
const path = require('path')

class CoffeeScriptAsset extends Asset {
  constructor(name, options) {
    super(name, options)
    this.type = 'js'
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