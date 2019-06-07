const fs = require('fs')
const path = require('path')
const cp = require('child_process')
const log = require('@neft/core/src/log')

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
      log.warn('Cannot resolve local IP address; is ifconfig or ipconfig commands available?')
      return 'localhost'
    }
  }

  return String(result).split('\n')[0].trim()
})()
