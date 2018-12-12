const log = require('../log')
const utils = require('../util')
const Struct = require('../struct')
const { SignalsEmitter } = require('../signal')

const PROP_OPTS = 0

class ScriptExported extends Struct {
  constructor(document, obj) {
    super(obj)
    utils.defineProperty(this, 'element', PROP_OPTS, document.element)
    utils.defineProperty(this, 'refs', PROP_OPTS, document.refs)
    utils.defineProperty(this, 'context', PROP_OPTS, () => document.context, null)
    utils.defineProperty(this, 'self', PROP_OPTS, this)
    Object.keys(this).forEach((key) => {
      if (typeof this[key] === 'function') {
        this[key] = this[key].bind(this)
      }
    })
  }
}

utils.defineProperty(ScriptExported.prototype, 'constructor', PROP_OPTS, ScriptExported)

SignalsEmitter.createSignal(ScriptExported, 'onRefsChange')
SignalsEmitter.createSignal(ScriptExported, 'onContextChange')

class Script {
  constructor(document, script) {
    this.document = document
    this.script = script
    this.object = this.combineObject()
    this.exported = new ScriptExported(this.document, this.object)
    this.defaults = null
  }

  combineObject() {
    const object = this.script || {}

    if (utils.isObject(object)) {
      Object.keys(object).forEach((key) => {
        if (utils.isObject(object[key])) {
          log.warn(`Document script exports a structure under the \`${key}\` key; \
it's dangerous because complex structures are shared between renders; \
initialize this key in the \`onRender()\` method to fix this warning`)
        }
      })
    }

    Object.keys(this.document.props).forEach((prop) => {
      if (!(prop in object)) {
        object[prop] = null
      }
    })

    return object
  }

  provideDefaults() {
    const defaults = {}
    Object.keys(this.exported).forEach((key) => {
      if (typeof this.exported[key] !== 'function') {
        defaults[key] = this.exported[key]
      }
    })
    return defaults
  }

  afterCreate() {
    if (typeof this.exported.onCreate === 'function') this.exported.onCreate()
    this.defaults = this.provideDefaults()
  }

  beforeRender() {
    if (typeof this.exported.onBeforeRender === 'function') this.exported.onBeforeRender()
  }

  afterRender() {
    if (typeof this.exported.onRender === 'function') this.exported.onRender()
  }

  beforeRevert() {
    if (typeof this.exported.onBeforeRevert === 'function') this.exported.onBeforeRevert()
  }

  afterRevert() {
    utils.merge(this.exported, this.defaults)
    if (typeof this.exported.onRevert === 'function') this.exported.onRevert()
  }
}

module.exports = Script
