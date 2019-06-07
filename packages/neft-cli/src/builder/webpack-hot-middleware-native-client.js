const querystring = require('querystring')
const EventSource = require('@neft/event-source')
const request = require('@neft/request')

const { localIp, devServerPort } = querystring.parse(__resourceQuery.slice(1))

window.EventSource = EventSource

window.XMLHttpRequest = class XMLHttpRequest {
  constructor() {
    this.method = ''
    this.uri = ''
    this.status = 0
    this.timeout = NaN
    this.readyState = 0
    this.responseText = 0
    this.onreadystatechange = null
  }

  open(method, uri) {
    this.method = method
    this.uri = uri
    this.readyState = 1
  }

  async send(body) {
    this.readyState = 4
    try {
      const response = await request({
        method: this.method,
        uri: this.uri,
        body,
        timeout: this.timeout,
        resolveWithFullResponse: true,
      })
      this.status = response.statusCode
      this.responseText = response.body
    } catch (error) {
      // NOP
    }
    if (typeof this.onreadystatechange === 'function') this.onreadystatechange()
  }
}

window.importScripts = async (...scripts) => {
  await Promise.all(scripts.map(async (script) => {
    const body = await request(script)
    eval(body)
  }))
}

const client = require('webpack-hot-middleware/client?autoConnect=false')

client.setOptionsAndConnect({
  path: `http://${localIp}:${devServerPort}/__webpack_hmr`,
  overlay: false,
})
