const coffee = require('coffee-script')
const babelJest = require('babel-jest')

module.exports = {
  process: (src, path, ...rest) => {
    if (coffee.helpers.isCoffee(path)) {
      const compiled = coffee.compile(src, { bare: true, literate: path.endsWith('.litcoffee') })
      return babelJest.process(compiled, path, ...rest)
    }
    return src
  },
}
