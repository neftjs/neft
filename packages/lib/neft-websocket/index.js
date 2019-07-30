const { NativeClientBinding, SignalDispatcher, util } = require('@neft/core')

const { callNativeFunction, onNativeEvent } = new NativeClientBinding('Websocket')

const SIGNALS = ['onClose', 'onError', 'onMessage', 'onOpen']
const CONNECTING = 0
const OPEN = 1
const CLOSING = 2
const CLOSED = 3

let nextUid = 0
const sockets = Object.create(null)
const uid = Symbol('uid')
const getSignal = Symbol('getSignal')

onNativeEvent('open', (wsUid) => {
  const socket = sockets[wsUid]
  if (!socket) return
  socket.readyState = OPEN
  socket.onOpen.emit()
})

onNativeEvent('message', (wsUid, data) => {
  const socket = sockets[wsUid]
  if (!socket) return
  socket.onMessage.emit({
    data,
  })
})

onNativeEvent('error', (wsUid, message) => {
  const socket = sockets[wsUid]
  if (!socket) return
  socket.onError.emit({
    message,
  })
})

onNativeEvent('close', (wsUid, code, reason) => {
  const socket = sockets[wsUid]
  if (!socket) return
  this.readyState = CLOSED
  socket.onClose.emit({
    code,
    reason,
  })
  delete sockets[wsUid]
})

class WebSocket {
  constructor(url) {
    nextUid += 1
    this[uid] = nextUid
    this.url = url
    this.readyState = CONNECTING
    this.onclose = null
    this.onerror = null
    this.onmessage = null
    this.onopen = null
    this.onClose = new SignalDispatcher()
    this.onError = new SignalDispatcher()
    this.onMessage = new SignalDispatcher()
    this.onOpen = new SignalDispatcher()
    Object.seal(this)

    sockets[this[uid]] = this
    callNativeFunction('connect', String(this[uid]), String(url))

    SIGNALS.forEach((signal) => {
      const property = signal.toLowerCase()
      this[signal].connect((event) => {
        if (typeof this[property] === 'function') {
          this[property](event)
        }
      })
    })
  }

  [getSignal](event) {
    const signal = `on${util.capitalize(event)}`
    return this[signal]
  }

  addEventListener(event, listener) {
    const signal = this[getSignal](event)
    if (signal) signal.connect(listener)
  }

  removeEventListener(event, listener) {
    const signal = this[getSignal](event)
    if (signal) signal.disconnect(listener)
  }

  send(data) {
    callNativeFunction('send', String(this[uid]), String(data))
  }

  close(code = 1005, reason = '') {
    this.readyState = CLOSING
    callNativeFunction('close', String(this[uid]), Number(code) || null, String(reason))
  }
}

WebSocket.CONNECTING = CONNECTING
WebSocket.OPEN = OPEN
WebSocket.CLOSING = CLOSING
WebSocket.CLOSED = CLOSED

module.exports = WebSocket
