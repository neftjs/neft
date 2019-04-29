const rimraf = require('rimraf')

exports.clean = () => {
  rimraf.sync('./dist')
  rimraf.sync('./node_modules/.cache')
}
