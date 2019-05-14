const fs = require('fs')
const npm = require('npm')
const files = require('./files')

const folders = ['./src', './src/components', './src/components/App']

exports.initialize = () => {
  folders.forEach((folder) => {
    if (!fs.existsSync(folder)) fs.mkdirSync(folder)
  })
  Object.keys(files).forEach((filepath) => {
    fs.writeFileSync(filepath, files[filepath])
  })
  npm.load((loadError) => {
    if (loadError) {
      console.error(loadError.message)
      process.exit(1)
    }
    npm.commands.install(['@neftio/core', '@neftio/default-styles'], (error) => {
      if (error) {
        console.error(error.message)
        process.exit(1)
      }
    })
  })
}
