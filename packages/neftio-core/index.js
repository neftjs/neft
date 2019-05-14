const { render } = require('./src/initializer')
const {
  callNativeFunction, onNativeEvent, registerNativeFunction, publishNativeEvent,
} = require('./src/native')
const { SignalDispatcher, SignalsEmitter } = require('./src/signal')
const Resources = require('./src/resources')
const Renderer = require('./src/renderer')
const log = require('./src/log')
const Element = require('./src/document/element')

// native
exports.callNativeFunction = callNativeFunction
exports.onNativeEvent = onNativeEvent
exports.registerNativeFunction = registerNativeFunction
exports.publishNativeEvent = publishNativeEvent

// utilities
exports.logger = log
exports.util = require('./src/util')
exports.Struct = require('./src/struct')
exports.ObservableArray = require('./src/observable-array')

// signal
exports.SignalDispatcher = SignalDispatcher
exports.SignalsEmitter = SignalsEmitter

// document
exports.CustomTag = Element.Tag.CustomTag

// renderer
exports.render = render
exports.loadFont = Renderer.loadFont
exports.NativeStyleItem = Renderer.Native
exports.Device = Renderer.Device
exports.Screen = Renderer.Screen
exports.Navigator = Renderer.Navigator

// resources
exports.resources = new Resources()
Renderer.setResources(exports.resources)

Object.freeze(exports)
