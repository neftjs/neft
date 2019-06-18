const cp = require('child_process')
const { promisify } = require('util')

module.exports = async () => {
  await promisify(cp.exec)('open dist/ios/Neft.xcodeproj')
}
