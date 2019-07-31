const fs = require('fs')
const path = require('path')
const cp = require('child_process')
const { logger } = require('@neft/core')

exports.realpath = fs.realpathSync('.')

exports.packageFile = JSON.parse(fs.readFileSync(path.join(exports.realpath, '/package.json'), 'utf-8'))

exports.packageConfig = exports.packageFile.config || {}

exports.outputDir = path.join(exports.realpath, '/dist')

exports.staticDir = path.join(exports.realpath, '/static')

exports.outputFile = 'bundle.js'

exports.operations = {
  build: true,
  run: true,
  clean: true,
}

exports.operationsWithoutTarget = {
  clean: true,
}

exports.targets = {
  node: true,
  html: true,
  webgl: true,
  android: true,
  ios: true,
  macos: true,
  file: true,
}

exports.args = {
  build: {
    file: ['file'],
  },
}

exports.options = {
  production: true,
}

exports.devServerPort = 3101

exports.hmrServerPort = 3102

exports.localIp = (() => {
  let result
  const command = 'ifconfig | '
    + "grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | "
    + "grep -Eo '([0-9]*\\.){3}[0-9]*' | "
    + "grep -v '127.0.0.1'"

  try {
    result = cp.execSync(command, { stdio: 'pipe' })
  } catch (error) {
    try {
      result = cp.execSync('ipconfig getifaddr en0', { stdio: 'pipe' })
    } catch (error2) {
      logger.warn('Cannot resolve local IP address; is ifconfig or ipconfig commands available?')
      return 'localhost'
    }
  }

  return String(result).split('\n')[0].trim()
})()
