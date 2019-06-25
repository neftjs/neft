/* eslint-disable no-restricted-syntax */
const fs = require('fs')
const https = require('https')
const Koa = require('koa')
const WebSocket = require('ws')
const route = require('koa-route')
const cors = require('@koa/cors')

const GC_TIMEOUT = 1000 * 60 * 5
const GC_INTERVAL = 1000 * 60 * 3

const app = new Koa()
const server = https.createServer({
  cert: fs.readFileSync('/cert/cert.pem'),
  key: fs.readFileSync('/cert/privkey.pem'),
}, app.callback())

const wss = new WebSocket.Server({ server, path: '/socket' })

server.listen(443)

const connections = Object.create(null)

const getKey = () => String(Math.round(Math.random() * (10 ** 6) + (10 ** 6))).slice(-6)

const getConnection = (key) => {
  let connection = connections[key]
  if (!connection) {
    connection = { time: 0, code: '', clients: new Set() }
    connections[key] = connection
  }
  return connection
}

const listenToConnection = (key, ws) => {
  const connection = getConnection(key)
  if (connection.code) {
    ws.send(connection.code)
  }
  connection.time = Date.now()
  connection.clients.add(ws)
}

const pushToConnection = (key, code) => {
  const connection = getConnection(key)
  connection.time = Date.now()
  connection.code = code
  connection.clients.forEach((client) => {
    client.send(code)
  })
}

const deleteConnectionClient = (key, ws) => {
  const connection = getConnection(key)
  connection.clients.delete(ws)
  if (!connection.clients.size) {
    delete connections[key]
  }
}

setInterval(() => {
  // eslint-disable-next-line guard-for-in
  for (const key in connections) {
    const connection = connections[key]
    if (Date.now() - connection.time > GC_TIMEOUT) {
      connection.clients.forEach((client) => {
        client.close()
      })
      delete connections[key]
    }
  }
}, GC_INTERVAL)

app.use(cors())

app.use(route.get('/hello', (ctx) => {
  let key
  do {
    key = getKey()
  } while (connections[key])
  ctx.body = key
}))

wss.on('connection', (ws) => {
  let key

  ws.on('close', () => {
    if (key) deleteConnectionClient(key, ws)
  })

  ws.on('message', (message) => {
    let listen
    let push
    let code
    try {
      ({ listen, push, code } = JSON.parse(message))
    } catch (error) {
      return
    }
    key = listen || push

    // mobile app
    if (listen) {
      listenToConnection(key, ws)
    }

    // editor
    if (push) {
      pushToConnection(key, code)
    }
  })
})
