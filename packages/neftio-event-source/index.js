const { callNativeFunction, onNativeEvent } = require('@neftio/core')

const NATIVE_PREFIX = 'NeftEventSource'
const CONNECT = `${NATIVE_PREFIX}/connect`
const CLOSE = `${NATIVE_PREFIX}/close`
const ON_CONNECTED = `${NATIVE_PREFIX}/connected`
const ON_MESSAGE = `${NATIVE_PREFIX}/message`
const ON_ERROR = `${NATIVE_PREFIX}/error`
const ON_CLOSED = `${NATIVE_PREFIX}/closed`

const CONNECTING = 0
const OPEN = 1
const CLOSED = 2

class EventSourceEvent {
  constructor({ lastEventId, data }) {
    this.lastEventId = lastEventId
    this.data = data
  }
}

const UID = Symbol('uid')
const instances = Object.create(null)

let lastUid = 0

class EventSource {
  constructor(url) {
    this[UID] = lastUid
    this.readyState = CONNECTING
    this.url = url
    this.onerror = null
    this.onmessage = null
    this.onopen = null

    lastUid += 1
    instances[this[UID]] = this

    callNativeFunction(CONNECT, this[UID], String(url))
  }

  close() {
    callNativeFunction(CLOSE, this[UID])
  }
}

EventSource.CONNECTING = CONNECTING
EventSource.OPEN = OPEN
EventSource.CLOSED = CLOSED

EventSource.prototype.CONNECTING = CONNECTING
EventSource.prototype.OPEN = OPEN
EventSource.prototype.CLOSED = CLOSED

onNativeEvent(ON_CONNECTED, (uid) => {
  const eventSource = instances[uid]
  if (!eventSource) return
  eventSource.readyState = OPEN
  if (typeof eventSource.onopen === 'function') eventSource.onopen()
})

onNativeEvent(ON_MESSAGE, (uid, lastEventId, data) => {
  const eventSource = instances[uid]
  if (!eventSource) return
  if (typeof eventSource.onmessage === 'function') {
    const event = new EventSourceEvent({ lastEventId, data })
    eventSource.onmessage(event)
  }
})

onNativeEvent(ON_ERROR, (uid, message) => {
  const eventSource = instances[uid]
  if (!eventSource) return
  if (typeof eventSource.onerror === 'function') {
    eventSource.onerror(new Error(message))
  }
})

onNativeEvent(ON_CLOSED, (uid, willReconnect) => {
  const eventSource = instances[uid]
  if (!eventSource) return
  eventSource.readyState = willReconnect ? CONNECTING : CLOSED
})

module.exports = EventSource
