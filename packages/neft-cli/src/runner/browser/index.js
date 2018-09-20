const { createServer } = require('http-server')
const opn = require('opn')

const host = 'localhost'
const port = '8080'

module.exports = () => {
  createServer({ root: './dist', cache: 0 }).listen(port, host)
  opn(`http://${host}:${port}`)
}
