const { createServer } = require('http-server')
const opn = require('opn')
const log = require('@neftio/core/src/log')
const { localIp, devServerPort } = require('../../config')

const host = localIp

module.exports = ({ production }) => {
  if (production) {
    // webpack runs a browser for development
    createServer({ root: './dist/html/', cache: 0 }).listen(devServerPort, host)
    log.info(`Start server on port \`${devServerPort}\``)
  }
  opn(`http://${host}:${devServerPort}`)
}
