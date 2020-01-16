const util = require('../util')
const eventLoop = require('../event-loop')
const { SignalDispatcher } = require('../signal')

const privatePropOpts = util.CONFIGURABLE | util.WRITABLE
const propOpts = util.CONFIGURABLE | util.ENUMERABLE

const createProperty = (observable, key, value) => {
  const privateKey = `_${key}`
  const signalName = `on${util.capitalize(key)}Change`
  const signal = new SignalDispatcher()
  util.defineProperty(observable, privateKey, privatePropOpts, value)
  util.defineProperty(observable, signalName, privatePropOpts, signal)
  const getter = function () {
    return this[privateKey]
  }
  const setter = function (newValue) {
    const oldVal = this[privateKey]
    if (newValue === oldVal) return
    this[privateKey] = newValue
    this[signalName].emit(oldVal)
  }
  util.defineProperty(observable, key, propOpts, getter, eventLoop.bindInLock(setter))
}

const observableSet = function (prop, value) {
  createProperty(this, prop, value)
}

const populateStandardMethods = (observable) => {
  util.defineProperty(observable, 'set', privatePropOpts, observableSet)
}

exports.from = (object) => {
  const observable = Object.create(object)
  populateStandardMethods(observable)
  Object.keys(object).forEach((key) => {
    createProperty(observable, key, object[key])
  })
  return observable
}
