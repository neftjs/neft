const { registerNativeFunction, publishNativeEvent } = require('./handler')

const getFullName = Symbol('getFullName')

class NativeServerBinding {
  constructor(module) {
    this.module = module
    this.onCall = this.onCall.bind(this)
    this.pushEvent = this.pushEvent.bind(this)
    Object.freeze(this)
  }

  [getFullName](name) {
    return `${this.module}/${name}`
  }

  onCall(name, handler) {
    registerNativeFunction(this[getFullName](name), handler)
    return this
  }

  pushEvent(name, args) {
    publishNativeEvent(this[getFullName](name), args)
  }
}

module.exports = NativeServerBinding
