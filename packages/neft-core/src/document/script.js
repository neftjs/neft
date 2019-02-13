const util = require('../util')
const Struct = require('../struct')
const { SignalsEmitter } = require('../signal')

const PROP_OPTS = 0

class ScriptExported extends Struct {
  constructor(document, obj) {
    super(obj)
    util.defineProperty(this, 'element', PROP_OPTS, document.element)
    util.defineProperty(this, 'refs', PROP_OPTS, document.refs)
    util.defineProperty(this, 'context', PROP_OPTS, () => document.context, null)
    util.defineProperty(this, 'self', PROP_OPTS, this)
    Object.keys(this).forEach((key) => {
      if (typeof this[key] === 'function') {
        this[key] = this[key].bind(this)
      }
    })
  }
}

util.defineProperty(ScriptExported.prototype, 'constructor', PROP_OPTS, ScriptExported)

SignalsEmitter.createSignal(ScriptExported, 'onRefsChange')

class Script {
  constructor(document, script) {
    this.document = document
    this.script = script
  }

  combineObject() {
    let object
    if (typeof this.script === 'function') object = this.script()
    if (util.isObject(this.script)) object = util.clone(this.script)
    if (!object) object = {}

    Object.keys(this.document.props).forEach((prop) => {
      if (!(prop in object)) {
        object[prop] = null
      }
    })

    return object
  }

  produceExported() {
    return new ScriptExported(this.document, this.combineObject())
  }

  afterRender() {
    if (typeof this.document.exported.onRender === 'function') this.document.exported.onRender()
  }

  beforeRevert() {
    if (typeof this.document.exported.onRevert === 'function') this.document.exported.onRevert()
  }
}

module.exports = Script
