const util = require('../util')
const assert = require('../assert')
const { SignalsEmitter } = require('../signal')

const privatePropOpts = util.CONFIGURABLE | util.WRITABLE
const propOpts = util.CONFIGURABLE | util.ENUMERABLE

const createProperty = (struct, key, value) => {
  const privateKey = `_${key}`
  const signalName = `on${util.capitalize(key)}Change`
  util.defineProperty(struct, privateKey, privatePropOpts, value)
  SignalsEmitter.createSignal(struct, signalName)
  const getter = function () {
    return this[privateKey]
  }
  const setter = function (newValue) {
    const oldVal = this[privateKey]
    if (newValue === oldVal) return
    this[privateKey] = newValue
    this.emit(signalName, oldVal)
  }
  util.defineProperty(struct, key, propOpts, getter, setter)
}

class Struct extends SignalsEmitter {
  constructor(obj) {
    super()

    assert.instanceOf(this, Struct, "Constructor Struct requires 'new'")

    if (util.isPlainObject(obj)) {
      Object.keys(obj).forEach((key) => {
        createProperty(this, key, obj[key])
      })
    }

    if (this.constructor === Struct) {
      Object.seal(this)
    }
  }
}

module.exports = Struct
