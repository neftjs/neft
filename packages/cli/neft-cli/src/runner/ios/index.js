const path = require('path')
const cp = require('child_process')
const fs = require('fs').promises
const { promisify } = require('util')

module.exports = async () => {
  const dir = 'dist/ios'
  const xcworkspace = path.join(dir, 'Neft.xcworkspace')
  const xcodeproj = path.join(dir, 'Neft.xcodeproj')
  try {
    await fs.stat(xcworkspace)
    await promisify(cp.exec)(`open ${xcworkspace}`)
  } catch (error) {
    await promisify(cp.exec)(`open ${xcodeproj}`)
  }
}
