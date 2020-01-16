const { render } = require('./initializer')
const { NativeClientBinding, NativeServerBinding } = require('./native')
const { SignalDispatcher, SignalsEmitter } = require('./signal')
const Resources = require('./resources')
const Renderer = require('./renderer')
const Document = require('./document')
const Element = require('./document/element')

// native
exports.NativeClientBinding = NativeClientBinding
exports.NativeServerBinding = NativeServerBinding

// utilities
exports.logger = require('./log')
exports.util = require('./util')
exports.assert = require('./assert')
exports.Struct = require('./struct')
exports.ObservableArray = require('./observable-array')
exports.ObservableObject = require('./observable-object')
exports.eventLoop = require('./event-loop')

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
exports.Item = Renderer.Item
exports.NativeStyleItem = Renderer.Native
exports.device = Renderer.device
exports.screen = Renderer.screen
exports.navigator = Renderer.navigator

// resources
exports.Resource = Resources.Resource
exports.Resources = Resources
exports.resources = new Resources()
Renderer.setResources(exports.resources)

Object.freeze(exports)
