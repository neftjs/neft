require('@neft/parcel-util')
const { Asset } = require('parcel-bundler')
const { bundle } = require('@neft/compiler-style')

class NmlAsset extends Asset {
  constructor(name, options) {
    super(name, options)
    this.type = 'js'
  }

  generate() {
    this.parsed = bundle(this.contents, { resourcePath: this.id })

    return [{
      type: 'js',
      value: `module.exports = (() => { ${this.parsed.bundle} })()`,
      map: '',
    }]
  }

  postProcess(generated) {
    const js = generated[0]

    return [{
      type: 'js',
      value: js.value,
      queries: this.parsed.queries,
      map: '',
    }]
  }
}

module.exports = NmlAsset
