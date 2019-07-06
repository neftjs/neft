const { render } = require('./initializer')
const { NativeClientBinding, NativeServerBinding } = require('./native')
const { SignalDispatcher, SignalsEmitter } = require('./signal')
const Resources = require('./resources')
const Renderer = require('./renderer')
const log = require('./log')
const Document = require('./document')
const Element = require('./document/element')

// native
exports.NativeClientBinding = NativeClientBinding
exports.NativeServerBinding = NativeServerBinding

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
exports.device = Renderer.Device
exports.screen = Renderer.Screen
exports.navigator = Renderer.Navigator

// resources
exports.Resource = Resources.Resource
exports.Resources = Resources
exports.resources = new Resources()
Renderer.setResources(exports.resources)

Object.freeze(exports)
