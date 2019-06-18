const log = require('../log')

const disconnectFromListeners = (listeners, listener, ctx) => {
  if (!listeners) return

  let index = 0

  while (index < listeners.length) {
    index = listeners.indexOf(listener, index)
    if (index === -1) return
    if (listeners[index + 1] === ctx) {
      listeners[index] = null
      listeners[index + 1] = null
      return
    }
    index += 2
  }
}

const clearListenersGaps = (listeners) => {
  let i = 0
  const n = listeners.length
  let shift = 0
  while (i < n) {
    const func = listeners[i]
    if (func === null) {
      shift += 2
    } else if (shift > 0) {
      listeners[i - shift] = func
      listeners[i - shift + 1] = listeners[i + 1]
      listeners[i] = null
      listeners[i + 1] = null
    }
    i += 2
  }
}

const callListeners = (object, listeners, arg1, arg2) => {
  if (!listeners) return

  let i = 0
  const n = listeners.length
  let containsGaps = false
  while (i < n) {
    const func = listeners[i]
    if (func === null) {
      containsGaps = true
    } else {
      const ctx = listeners[i + 1]
      try {
        func.call(ctx || object, arg1, arg2)
      } catch (error) {
        log.error('Uncaught error thrown in signal listener', error)
      }
    }
    i += 2
  }

  if (containsGaps) {
    clearListenersGaps(listeners)
  }
}

class Signal {
  constructor() {
    this.listeners = null
    Object.seal(this)
  }

  connect(listener, ctx = null) {
    const { listeners } = this
    if (!listeners) return

    const n = listeners.length
    let i = n - 2
    while (i >= 0) {
      if (listeners[i] !== null) {
        break
      }
      i -= 2
    }

    if (i + 2 === n) {
      listeners.push(listener, ctx)
    } else {
      listeners[i + 2] = listener
      listeners[i + 3] = ctx
    }
  }

  connectOnce(listener, ctx = null) {
    const { listeners } = this
    if (!listeners) return

    const wrapper = function (arg1, arg2) {
      disconnectFromListeners(listeners, wrapper, ctx)
      listener.call(this, arg1, arg2)
    }

    this.connect(wrapper, ctx)
  }

  disconnect(listener, ctx = null) {
    disconnectFromListeners(this.listeners, listener, ctx)
  }

  disconnectAll() {
    const { listeners } = this
    if (!listeners) return
    for (let i = 0, n = listeners.length; i < n; i += 1) {
      listeners[i] = null
    }
  }

  isEmpty() {
    const { listeners } = this
    if (!listeners) return true
    for (let i = 0, n = listeners.length; i < n; i += 2) {
      if (listeners[i] !== null) return false
    }
    return true
  }
}

exports.Signal = Signal
exports.callListeners = callListeners
