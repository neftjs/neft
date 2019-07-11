/* eslint-disable global-require */
/* eslint-disable no-plusplus */
const utils = require('../util')
const log = require('../log')
const assert = require('../assert')
const eventLoop = require('../event-loop')

const listeners = Object.create(null)

const reader = {
  booleans: null,
  booleansIndex: 0,
  integers: null,
  integersIndex: 0,
  floats: null,
  floatsIndex: 0,
  strings: null,
  stringsIndex: 0,
  getBoolean() {
    if (process.env.NODE_ENV === 'development') {
      if (this.booleansIndex >= this.booleans.length) {
        throw new Error(`Index ${this.booleansIndex} out of range for native booleans array`)
      }
    }
    return this.booleans[this.booleansIndex++]
  },
  getInteger() {
    if (process.env.NODE_ENV === 'development') {
      if (this.integersIndex >= this.integers.length) {
        throw new Error(`Index ${this.booleansIndex} out of range for native integers array`)
      }
    }
    return this.integers[this.integersIndex++]
  },
  getFloat() {
    if (process.env.NODE_ENV === 'development') {
      if (this.floatsIndex >= this.floats.length) {
        throw new Error(`Index ${this.booleansIndex} out of range for native floats array`)
      }
    }
    return this.floats[this.floatsIndex++]
  },
  getString() {
    if (process.env.NODE_ENV === 'development') {
      if (this.stringsIndex >= this.strings.length) {
        throw new Error(`Index ${this.booleansIndex} out of range for native strings array`)
      }
    }
    return this.strings[this.stringsIndex++]
  },
}

Object.seal(reader)

const bridge = {}

bridge.onData = function (actions, booleans, integers, floats, strings) {
  reader.booleans = booleans
  reader.booleansIndex = 0
  reader.integers = integers
  reader.integersIndex = 0
  reader.floats = floats
  reader.floatsIndex = 0
  reader.strings = strings
  reader.stringsIndex = 0
  eventLoop.lock()
  actions.forEach((action) => {
    const func = listeners[action]
    try {
      assert.isFunction(func, `Unknown native action got '${action}'`)
      func(reader)
    } catch (error) {
      log.error('Uncaught error when processing native events', error)
    }
  })
  eventLoop.release()
  bridge.sendData()
}

bridge.addActionListener = function (action, listener) {
  assert.isInteger(action)
  assert.isFunction(listener)
  assert.isNotDefined(listeners[action], `action '${action}' already has a listener`)
  listeners[action] = listener
}

bridge.sendData = function () {}

bridge.pushAction = function () {}

bridge.pushBoolean = function () {}

bridge.pushInteger = function () {}

bridge.pushFloat = function () {}

bridge.pushString = function () {}

bridge.registerNativeFunction = function () {}

bridge.publishNativeEvent = function () {}

let impl

if (process.env.NEFT_ANDROID) {
  impl = require('./impl/android/bridge')
}

if (process.env.NEFT_IOS) {
  impl = require('./impl/ios/bridge')
}

if (process.env.NEFT_MACOS) {
  impl = require('./impl/macos/bridge')
}

if (process.env.NEFT_BROWSER) {
  impl = require('./impl/browser/bridge')
}

if (impl != null) {
  utils.merge(bridge, impl(bridge))
}

if (process.env.NODE_ENV === 'development') {
  bridge.pushAction = (function (_super) {
    return function (val) {
      assert.isInteger(val, `integer action expected, but '${val}' given`)
      _super(val)
    }
  }(bridge.pushAction))

  bridge.pushBoolean = (function (_super) {
    return function (val) {
      assert.isBoolean(val, `boolean expected, but '${val}' given`)
      _super(val)
    }
  }(bridge.pushBoolean))

  bridge.pushInteger = (function (_super) {
    return function (val) {
      assert.isInteger(val, `integer expected, but '${val}' given`)
      _super(val)
    }
  }(bridge.pushInteger))

  bridge.pushFloat = (function (_super) {
    return function (val) {
      assert.isFloat(val, `float expected, but '${val}' given`)
      _super(val)
    }
  }(bridge.pushFloat))

  bridge.pushString = (function (_super) {
    return function (val) {
      assert.isString(val, `string expected, but '${val}' given`)
      _super(val)
    }
  }(bridge.pushString))
}

exports.onData = bridge.onData
exports.addActionListener = bridge.addActionListener
exports.sendData = bridge.sendData
exports.registerNativeFunction = bridge.registerNativeFunction
exports.publishNativeEvent = bridge.publishNativeEvent
exports.pushAction = bridge.pushAction
exports.pushBoolean = bridge.pushBoolean
exports.pushInteger = bridge.pushInteger
exports.pushFloat = bridge.pushFloat
exports.pushString = bridge.pushString
