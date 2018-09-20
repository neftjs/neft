const fs = require('fs-promise-native')
const path = require('path')
const Jimp = require('jimp')
const { realpath, outputDir } = require('../config')

const resizeImage = (filepath, width, height, output) => new Promise((resolve, reject) => {
  Jimp.read(filepath, (err, image) => {
    if (err) return reject(err)
    return image.resize(width, height).write(output, (err2) => {
      if (err2) return reject(err2)
      return resolve()
    })
  })
})

exports.generateIcons = async ({ target, icons, manifest }) => {
  if (!manifest.icon) return
  const icon = path.join(realpath, '/manifest', manifest.icon)
  const output = path.join(outputDir, '/icon/', target)

  // create output
  try {
    await fs.mkdir(path.join(outputDir, '/icon/'))
    await fs.mkdir(output)
  } catch (_error) {
    // already exists
  }

  // create icon files
  const promises = icons.map((definition) => {
    const fileOutput = path.join(output, definition.out)
    return resizeImage(icon, definition.width, definition.height, fileOutput)
  })

  await Promise.all(promises)
}
