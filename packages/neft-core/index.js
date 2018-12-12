const { render } = require('./src/initializer')
const {
  callNativeFunction, onNativeEvent, registerNativeFunction, publishNativeEvent,
} = require('./src/native')
const { SignalDispatcher, SignalsEmitter } = require('./src/signal')
const Resources = require('./src/resources')
const Renderer = require('./src/renderer')

exports.callNativeFunction = callNativeFunction
exports.onNativeEvent = onNativeEvent
exports.registerNativeFunction = registerNativeFunction
exports.publishNativeEvent = publishNativeEvent

exports.util = require('./src/util')
exports.Struct = require('./src/struct')
exports.ObservableArray = require('./src/observable-array')

exports.SignalDispatcher = SignalDispatcher
exports.SignalsEmitter = SignalsEmitter
exports.render = render
exports.loadFont = Renderer.loadFont
exports.resources = new Resources()
exports.setResources = (json) => {
  const resources = Resources.fromJSON(json)
  exports.resources = resources
  Renderer.setResources(resources)
  return resources
}
