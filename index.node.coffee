'use strict'

PORT = 3000

express = require 'express'
routing = express()
routing.listen PORT

routing.use express.compress()
routing.use express.json()
routing.use express.urlencoded()
routing.use express.cookieParser('sbS23treasRTHqeg')
routing.use express.cookieSession()

module.exports = routing