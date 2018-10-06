const { createServer } = require('http-server')
const opn = require('opn')
const log = require('@neft/core/src/log')
const { devServerPort } = require('../../config')

const host = 'localhost'

module.exports = ({ production }) => {
  if (production) {
    // webpack runs a browser for development
    createServer({ root: './dist/html/', cache: 0 }).listen(devServerPort, host)
    log.info(`Start server on port \`${devServerPort}\``)
  }
  opn(`http://${host}:${devServerPort}`)
}
