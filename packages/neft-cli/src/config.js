const fs = require('fs')
const path = require('path')

exports.realpath = fs.realpathSync('.')

exports.packageFile = JSON.parse(fs.readFileSync(path.join(exports.realpath, '/package.json'), 'utf-8'))

exports.packageConfig = exports.packageFile.config || {}

exports.outputDir = path.join(exports.realpath, '/dist')

exports.operations = {
  init: true,
  build: true,
  run: true,
  clean: true,
}

exports.operationsWithoutTarget = {
  init: true,
  clean: true,
}

exports.targets = {
  node: true,
  html: true,
  webgl: true,
  android: true,
  ios: true,
  macos: true,
}

exports.args = {
  production: true,
}

exports.targetEnvs = {
  node: {
    node: true,
    server: true,
  },
  html: {
    html: true,
    browser: true,
    client: true,
  },
  webgl: {
    webgl: true,
    browser: true,
    client: true,
  },
  android: {
    android: true,
    client: true,
    native: true,
  },
  ios: {
    ios: true,
    client: true,
    native: true,
    apple: true,
  },
  macos: {
    macos: true,
    client: true,
    native: true,
    apple: true,
  },
}

exports.devServerPort = 3000
