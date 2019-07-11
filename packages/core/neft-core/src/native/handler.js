/* eslint-disable prefer-rest-params */
const util = require('../util')
const assert = require('../assert')
const log = require('../log')
const actions = require('./actions')
const eventTypes = require('./event-types')
const bridge = require('./bridge')

const { CALL_FUNCTION } = actions.out
const {
  EVENT_NULL_TYPE, EVENT_BOOLEAN_TYPE, EVENT_INTEGER_TYPE, EVENT_FLOAT_TYPE, EVENT_STRING_TYPE,
} = eventTypes

const listeners = Object.create(null)

bridge.addActionListener(actions.in.EVENT, (reader) => {
  const args = []
  const name = reader.getString()
  const argsLen = reader.getInteger()
  for (let i = 0; i < argsLen; i += 1) {
    const type = reader.getInteger()
    switch (type) {
      case EVENT_NULL_TYPE:
        args[i] = null
        break
      case EVENT_BOOLEAN_TYPE:
        args[i] = reader.getBoolean()
        break
      case EVENT_INTEGER_TYPE:
        args[i] = reader.getInteger()
        break
      case EVENT_FLOAT_TYPE:
        args[i] = reader.getFloat()
        break
      case EVENT_STRING_TYPE:
        args[i] = reader.getString()
        break
      default:
        throw new Error('Unexpected native event argument type')
    }
  }
  const eventListeners = listeners[name]
  if (eventListeners) {
    eventListeners.forEach((listener) => {
      listener(...args)
    })
  } else {
    log.warn(`No listeners registered for the native event '${name}'`)
  }
})

let pushPending = false

const sendData = function () {
  pushPending = false
  bridge.sendData()
}

exports.callNativeFunction = function (name, args) {
  assert.isString(name, `native.callFunction name needs to be a string, but ${name} given`)
  assert.notLengthOf(name, 0, 'native.callFunction name cannot be an empty string')
  bridge.pushAction(CALL_FUNCTION)
  bridge.pushString(name)
  bridge.pushInteger(args.length)
  args.forEach((arg) => {
    switch (true) {
      case typeof arg === 'boolean':
        bridge.pushInteger(EVENT_BOOLEAN_TYPE)
        bridge.pushBoolean(arg)
        break
      case typeof arg === 'string':
        bridge.pushInteger(EVENT_STRING_TYPE)
        bridge.pushString(arg)
        break
      case util.isInteger(arg):
        bridge.pushInteger(EVENT_INTEGER_TYPE)
        bridge.pushInteger(arg)
        break
      case typeof arg === 'number':
        bridge.pushInteger(EVENT_FLOAT_TYPE)
        bridge.pushFloat(arg || 0)
        break
      default:
        if (arg != null) {
          log.warn(`Native function can be called with a boolean, integer, float or a string, but '${arg}' given`)
        }
        bridge.pushInteger(EVENT_NULL_TYPE)
    }
  })
  if (!pushPending && !process.env.NEFT_NATIVE) {
    pushPending = true
    setImmediate(sendData)
  }
}

exports.onNativeEvent = function (name, listener) {
  assert.isString(name, `native.onEvent name needs to be a string, but ${name} given`)
  assert.notLengthOf(name, 0, 'native.onEvent name cannot be an empty string')
  assert.isFunction(listener, `native.onEvent listener needs to be a function, but ${listener} given`)
  if (!listeners[name]) listeners[name] = []
  listeners[name].push(listener)
}

exports.registerNativeFunction = bridge.registerNativeFunction

exports.publishNativeEvent = bridge.publishNativeEvent
