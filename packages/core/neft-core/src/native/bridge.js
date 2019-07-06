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
    // <development>;
    if (this.booleansIndex >= this.booleans.length) {
      throw new Error(`Index ${this.booleansIndex} out of range for native booleans array`)
    }
    // </development>;
    return this.booleans[this.booleansIndex++]
  },
  getInteger() {
    // <development>;
    if (this.integersIndex >= this.integers.length) {
      throw new Error(`Index ${this.booleansIndex} out of range for native integers array`)
    }
    // </development>;
    return this.integers[this.integersIndex++]
  },
  getFloat() {
    // <development>;
    if (this.floatsIndex >= this.floats.length) {
      throw new Error(`Index ${this.booleansIndex} out of range for native floats array`)
    }
    // </development>;
    return this.floats[this.floatsIndex++]
  },
  getString() {
    // <development>;
    if (this.stringsIndex >= this.strings.length) {
      throw new Error(`Index ${this.booleansIndex} out of range for native strings array`)
    }
    // </development>;
    return this.strings[this.stringsIndex++]
  },
}

Object.seal(reader)

exports.onData = function (actions, booleans, integers, floats, strings) {
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
  exports.sendData()
}

exports.addActionListener = function (action, listener) {
  assert.isInteger(action)
  assert.isFunction(listener)
  assert.isNotDefined(listeners[action], `action '${action}' already has a listener`)
  listeners[action] = listener
}

exports.sendData = function () {}

exports.pushAction = function () {}

exports.pushBoolean = function () {}

exports.pushInteger = function () {}

exports.pushFloat = function () {}

exports.pushString = function () {}

exports.registerNativeFunction = function () {}

exports.publishNativeEvent = function () {}

exports.sendDataInLock = function () {
  return exports.sendData()
}

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
  utils.merge(exports, impl(exports))
}

if (process.env.NODE_ENV !== 'production') {
  exports.pushAction = (function (_super) {
    return function (val) {
      assert.isInteger(val, `integer action expected, but '${val}' given`)
      _super(val)
    }
  }(exports.pushAction))

  exports.pushBoolean = (function (_super) {
    return function (val) {
      assert.isBoolean(val, `boolean expected, but '${val}' given`)
      _super(val)
    }
  }(exports.pushBoolean))

  exports.pushInteger = (function (_super) {
    return function (val) {
      assert.isInteger(val, `integer expected, but '${val}' given`)
      _super(val)
    }
  }(exports.pushInteger))

  exports.pushFloat = (function (_super) {
    return function (val) {
      assert.isFloat(val, `float expected, but '${val}' given`)
      _super(val)
    }
  }(exports.pushFloat))

  exports.pushString = (function (_super) {
    return function (val) {
      assert.isString(val, `string expected, but '${val}' given`)
      _super(val)
    }
  }(exports.pushString))
}
