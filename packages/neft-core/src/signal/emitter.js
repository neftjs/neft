const util = require('../util')
const { Signal, callListeners } = require('./signal')
const { InternalSignalDispatcher } = require('./dispatcher')

function SignalsEmitter() {
  util.defineProperty(this, '_signals', null, {})
}

util.defineProperty(SignalsEmitter.prototype, 'emit', null, function (name, arg1, arg2) {
  const listeners = this._signals[name]
  if (!listeners) return
  callListeners(this, listeners, arg1, arg2)
})

class EmitterSharedSignal extends Signal {
  asSignalDispatcher() {
    return new InternalSignalDispatcher(this.listeners)
  }
}

const sharedSignal = new EmitterSharedSignal()

SignalsEmitter.createSignal = (target, name, onInitialized) => {
  const object = typeof target === 'function' ? target.prototype : target
  const getter = function () {
    const signals = this._signals
    if (!signals) return null
    let listeners = signals[name]
    if (!listeners) {
      listeners = [null, null, null, null]
      signals[name] = listeners
      if (typeof onInitialized === 'function') {
        onInitialized(this, name)
      }
    }
    sharedSignal.listeners = listeners
    return sharedSignal
  }
  util.defineProperty(object, name, null, getter, null)
}

exports.SignalsEmitter = SignalsEmitter
