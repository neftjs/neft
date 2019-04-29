const fs = require('fs-extra')
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
  await fs.ensureDir(output)

  // create icon files
  const promises = icons.map(async (definition) => {
    const fileOutput = path.join(output, definition.out)
    await fs.ensureDir(path.dirname(fileOutput))
    await resizeImage(icon, definition.width, definition.height, fileOutput)
  })

  await Promise.all(promises)
}
