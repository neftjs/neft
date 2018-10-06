const { callNativeFunction, onNativeEvent } = process.env.NEFT_NATIVE ? require('./src/native') : {}

exports.callNativeFunction = callNativeFunction
exports.onNativeEvent = onNativeEvent

exports.util = require('./src/util')
exports.signal = require('./src/signal')
exports.Struct = require('./src/struct')
exports.ObservableArray = require('./src/observable-array')
exports.render = require('./src/initializer').init
