const { Signal, callListeners } = require('./signal')

class InternalSignalDispatcher extends Signal {
  constructor(listeners) {
    super()
    this.listeners = listeners
    Object.freeze(this)
  }

  emit(arg1, arg2) {
    callListeners(null, this.listeners, arg1, arg2)
  }
}

class SignalDispatcher extends InternalSignalDispatcher {
  constructor() {
    super([])
  }
}

exports.SignalDispatcher = SignalDispatcher
exports.InternalSignalDispatcher = InternalSignalDispatcher
