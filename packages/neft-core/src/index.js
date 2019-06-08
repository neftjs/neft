const { render } = require('./initializer')
const {
  callNativeFunction, onNativeEvent, registerNativeFunction, publishNativeEvent,
} = require('./native')
const { SignalDispatcher, SignalsEmitter } = require('./signal')
const Resources = require('./resources')
const Renderer = require('./renderer')
const log = require('./log')
const Document = require('./document')
const Element = require('./document/element')

// native
exports.callNativeFunction = callNativeFunction
exports.onNativeEvent = onNativeEvent
exports.registerNativeFunction = registerNativeFunction
exports.publishNativeEvent = publishNativeEvent

// utilities
exports.logger = log
exports.util = require('./util')
exports.Struct = require('./struct')
exports.ObservableArray = require('./observable-array')

// signal
exports.SignalDispatcher = SignalDispatcher
exports.SignalsEmitter = SignalsEmitter

// document
exports.Document = Document
exports.Element = Element
exports.CustomTag = Element.Tag.CustomTag

// renderer
exports.render = render
exports.Renderer = Renderer
exports.loadFont = Renderer.loadFont
exports.NativeStyleItem = Renderer.Native
exports.Device = Renderer.Device
exports.Screen = Renderer.Screen
exports.Navigator = Renderer.Navigator

// resources
exports.Resource = Resources.Resource
exports.Resources = Resources
exports.resources = new Resources()
Renderer.setResources(exports.resources)

Object.freeze(exports)
