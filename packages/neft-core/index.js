const { callNativeFunction, onNativeEvent } = process.env.NEFT_NATIVE ? require('./src/native') : {}
const Resources = require('./src/resources')
const Renderer = require('./src/renderer')

exports.callNativeFunction = callNativeFunction
exports.onNativeEvent = onNativeEvent

exports.util = require('./src/util')
exports.signal = require('./src/signal')
exports.Struct = require('./src/struct')
exports.ObservableArray = require('./src/observable-array')
exports.render = require('./src/initializer').init

exports.resources = new Resources()
exports.setResources = (json) => {
  const resources = Resources.fromJSON(json)
  exports.resources = resources
  Renderer.setResources(resources)
  return resources
}
