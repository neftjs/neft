const util = require('../util')
const Struct = require('../struct')
const { SignalsEmitter } = require('../signal')

const PROP_OPTS = 0

class ScriptExported extends Struct {
  constructor(document, obj) {
    super(obj)
    util.defineProperty(this, '$element', PROP_OPTS, document.element)
    util.defineProperty(this, '$refs', PROP_OPTS, document.refs)
    util.defineProperty(this, '$context', PROP_OPTS, () => document.context, null)
  }
}

util.defineProperty(ScriptExported.prototype, 'constructor', PROP_OPTS, ScriptExported)

SignalsEmitter.createSignal(ScriptExported, 'on$RefsChange')

class Script {
  constructor(document, script) {
    class ComponentScript extends ScriptExported {}

    this.document = document
    this.produceInstanceFields = null
    this.ExportedConstructor = ComponentScript

    if (typeof script === 'function') {
      this.produceInstanceFields = script
    } else if (util.isObject(script)) {
      Object.keys(script).forEach((key) => {
        if (key !== 'default') ComponentScript.prototype[key] = script[key]
      })
      if (typeof script.default === 'function') {
        this.produceInstanceFields = script.default
      } else {
        this.produceInstanceFields = () => script.default
      }
    } else {
      this.produceInstanceFields = () => null
    }
  }

  produceExported() {
    // produce object with combined static methods and instance fields
    const object = this.produceInstanceFields() || {}

    // add props
    Object.keys(this.document.props).forEach((prop) => {
      if (!(prop in object)) {
        object[prop] = null
      }
    })

    // add states
    if (this.document.states) {
      this.document.states.forEach((state) => {
        if (!(state.name in object)) {
          object[state.name] = state.getValue()
        }
      })
    }

    // add contexts
    this.document.contexts.forEach((context) => {
      if (!(context.as in object)) {
        object[context.as] = null
      }
    })

    // create struct
    const exported = new this.ExportedConstructor(this.document, object)

    // bind instance methods
    Object.keys(object).forEach((field) => {
      if (typeof object[field] === 'function') {
        exported[field] = exported[field].bind(exported)
      }
    })

    return exported
  }

  afterRender() {
    if (typeof this.document.exported.onRender === 'function') {
      this.document.exported.onRender()
    }
  }

  beforeRevert() {
    if (typeof this.document.exported.onRevert === 'function') {
      this.document.exported.onRevert()
    }
  }
}

module.exports = Script
