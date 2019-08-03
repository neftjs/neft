const fs = require('fs-extra')
const path = require('path')
const util = require('util')
const sharp = require('sharp')
const glob = util.promisify(require('glob'))
const { logger } = require('@neft/core')
const { Resources, Resource } = require('@neft/core')
const { realpath, outputDir, staticDir } = require('../config')

const imageExtensions = {
  '.jpg': true,
  '.jpeg': true,
  '.png': true,
  '.webp': true,
  '.tiff': true,
  '.gif': true,
}

const ensureDir = (target, parts) => {
  const part = parts.shift()
  const newTarget = target[part] || new Resources()
  target[part] = newTarget
  if (parts.length) return ensureDir(newTarget, parts)
  return newTarget
}

const getNeededResolutions = (input) => {
  const resolutions = []
  let initial = input
  if (typeof input === 'string' && input.endsWith('x')) initial = initial.slice(0, -1)
  initial = parseFloat(initial)
  resolutions.push(initial)
  for (let i = Math.floor(initial); i > 0; i -= 1) {
    if (i !== initial) resolutions.push(i)
  }
  return { initialResolution: initial, resolutions }
}

const createLowResImage = async ({
  file, stat, metadata, resolution, initialResolution, output,
}) => {
  const lowRestWidth = Math.round(metadata.width * resolution / initialResolution)
  const lowRestHeight = Math.round(metadata.height * resolution / initialResolution)
  try {
    const outputStat = await fs.stat(output)
    if (outputStat.ctimeMs <= stat.ctimeMs) {
      throw new Error('Cache needs to be invalidated')
    }
    return null
  } catch (error) {
    const relativeInput = path.relative(realpath, file)
    const relativeOutput = path.relative(realpath, output)
    logger.log(`   Resize \`${relativeInput}\` -> \`${relativeOutput}\``)
    await fs.ensureDir(path.dirname(output))
    return sharp(file).resize(lowRestWidth, lowRestHeight).toFile(output)
  }
}

const processImage = async (file, dir, base, fullName, ext, target) => {
  const [name, imageResolution] = fullName.split('@')
  const { initialResolution, resolutions } = getNeededResolutions(imageResolution || '1x')
  const paths = {}
  const stat = await fs.stat(file)
  const metadata = await sharp(file).metadata()
  await Promise.all(resolutions.map(async (resolution) => {
    if (initialResolution === resolution) {
      paths[resolution] = path.join('/static', dir, base)
      return
    }
    const lowResName = path.join(dir, `${name}@${resolution}x${ext}`)
    await createLowResImage({
      file,
      name: lowResName,
      stat,
      metadata,
      resolution,
      initialResolution,
      output: path.join(outputDir, './static', lowResName),
    })
    paths[resolution] = path.join('/static', lowResName)
  }))

  const resource = new Resource()
  resource.file = path.join(dir, name)
  resource.name = name
  resource.width = metadata.width / initialResolution
  resource.height = metadata.height / initialResolution
  resource.formats = [ext]
  resource.resolutions = resolutions
  resource.paths = { [ext]: paths }
  target[name] = resource
}

const processAnyFile = (file, dir, base, name, ext, target) => {
  const resource = new Resource()
  resource.file = path.join(dir, name)
  resource.name = name
  resource.formats = [ext]
  resource.resolutions = [1]
  resource.paths = { [ext]: { 1: path.join('/static', dir, base) } }
  target[name] = resource
}

const mapFile = async (file, target) => {
  const {
    dir, base, name, ext,
  } = path.parse(path.relative(staticDir, file))
  const resources = ensureDir(target, dir.split('/'))
  if (imageExtensions[ext]) await processImage(file, dir, base, name, ext, resources)
  else await processAnyFile(file, dir, base, name, ext, resources)
}

exports.loadStaticFiles = async () => {
  const target = new Resources()
  const files = await glob(path.join(staticDir, '**/*.*'))
  await Promise.all(files.map(file => mapFile(file, target)))
  return `const { Resources, resources } = require('@neft/core')
Resources.fromJSON(${JSON.stringify(target)}, resources)\n`
}
