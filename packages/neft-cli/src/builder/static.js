const fs = require('fs')
const path = require('path')
const util = require('util')
const glob = util.promisify(require('glob'))
const log = require('@neft/core/src/log').scope('build:static')
const { realpath, outputDir } = require('../config')

const inDir = path.join(realpath, 'static')

const mapFile = async (file, target) => {
  const extname = path.extname(file)
  const name = path.relative(inDir, file)
  console.log(name, extname, file)
}

exports.loadStaticFiles = async () => {
  const target = {}
  const files = await glob(path.join(inDir, '**/*.*'))
  await Promise.all(files.map((file) => mapFile(file, target)))
  return target
}
