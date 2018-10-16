const fs = require('fs-promise-native')
const path = require('path')
const sharp = require('sharp')
const { realpath, outputDir } = require('../config')

const resizeImage = (filepath, width, height, output) => sharp(filepath)
  .resize(width, height)
  .toFile(output)

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
