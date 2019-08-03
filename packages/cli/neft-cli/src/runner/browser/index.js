const path = require('path')
const open = require('better-opn')
const serve = require('koa-static')
const Koa = require('koa')
const { logger } = require('@neft/core')
const {
  outputDir, staticDir, localIp, devServerPort,
} = require('../../config')

const host = localIp

module.exports = () => {
  const root = path.join(outputDir, 'html')
  const app = new Koa()
  app.use(serve(root))
  app.use(serve(outputDir))
  app.use(serve(path.join(staticDir, '../')))
  app.listen(devServerPort, host)
  logger.log(`-> Starting HTTP server on \`${host}:${devServerPort}\``)
  open(`http://${host}:${devServerPort}`)
}
