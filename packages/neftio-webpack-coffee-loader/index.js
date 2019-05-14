const coffee = require('coffee-script')
const loaderUtils = require('loader-utils')

module.exports = function (source) {
  this.cacheable()
  const coffeeRequest = loaderUtils.getRemainingRequest(this)
  const jsRequest = loaderUtils.getCurrentRequest(this)
  const literate = coffeeRequest.endsWith('.litcoffee') || coffeeRequest.endsWith('.coffee.md')
  const result = coffee.compile(source, {
    literate,
    filename: coffeeRequest,
    debug: this.debug,
    bare: true,
    sourceMap: true,
    sourceRoot: '',
    sourceFiles: [coffeeRequest],
    generatedFile: jsRequest,
  })
  const map = JSON.parse(result.v3SourceMap)
  map.sourcesContent = [source]
  this.callback(null, result.js, map)
}
