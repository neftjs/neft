const fs = require('fs-promise-native')
const path = require('path')
const yaml = require('js-yaml')
const { util } = require('@neft/core')
const { realpath } = require('../config')

exports.produceManifest = async ({ target, defaultManifest }) => {
  if (!defaultManifest) return {}

  // ensure dir
  try {
    await fs.mkdir(path.join(realpath, '/manifest'))
  } catch (_error) {
    // already exists
  }

  let filepath = path.join(realpath, `/manifest/${target}.yaml`)
  try {
    await fs.stat(filepath)
  } catch (error) {
    filepath = path.join(realpath, `/manifest/${target}.yml`)
  }

  let manifest
  try {
    manifest = yaml.safeLoad(await fs.readFile(filepath, 'utf-8'))
    manifest = util.mergeDeepAll({}, defaultManifest, manifest)
  } catch (_error) {
    // file doesn't exist
    manifest = defaultManifest
  }

  await fs.writeFile(filepath, yaml.safeDump(manifest))

  return manifest
}
