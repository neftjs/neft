const { callNativeFunction, onNativeEvent } = require('./handler')

const getFullName = Symbol('getFullName')

class NativeClientBinding {
  constructor(module) {
    this.module = module
    this.callNativeFunction = this.callNativeFunction.bind(this)
    this.onNativeEvent = this.onNativeEvent.bind(this)
    Object.freeze(this)
  }

  [getFullName](name) {
    return `${this.module}/${name}`
  }

  callNativeFunction(name, ...args) {
    callNativeFunction(this[getFullName](name), args)
  }

  onNativeEvent(name, listener) {
    onNativeEvent(this[getFullName](name), listener)
  }
}

module.exports = NativeClientBinding
