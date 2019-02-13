const utils = require('../util')
const assert = require('../assert')
const eventLoop = require('../event-loop')
const log = require('../log')
const Use = require('./use')
const Log = require('./log')
const Condition = require('./condition')
const TextInput = require('./input/text')
const PropInput = require('./input/prop')
const Script = require('./script')
const Target = require('./target')
const Iterator = require('./iterator')
const StyleItem = require('./style-item')

const parseComponents = (components) => {
  Object.keys(components).forEach((name) => {
    const file = components[name]
    if (typeof file === 'object' && file != null) {
      components[name] = file.default
    }
  })
  return components
}

const parseRefs = (refs, element) => Object.create(Object.keys(refs).reduce((result, key) => {
  result[key] = element.getChildByAccessPath(refs[key])
  return result
}, {}))

const mapToTypes = (Type, list, document) => {
  if (list) return list.map(opts => new Type(document, opts))
  return []
}

const isInternalProp = prop => prop[0] === 'n' && prop[1] === '-'

const getComponentGenerator = Symbol('getComponentGenerator')
const componentsPool = Symbol('componentsPool')
const renderProps = Symbol('renderProps')
const renderOnPropsChange = Symbol('renderOnPropsChange')
const renderSourceElement = Symbol('renderSourceElement')
const renderListeners = Symbol('renderListeners')
const callRenderListener = Symbol('callRenderListener')

let instances
let saveInstance
if (process.env.NODE_ENV === 'development') {
  instances = {}
  saveInstance = (document) => {
    const { path } = document
    instances[path] = instances[path] || []
    instances[path].push(document)
  }
}

class Document {
  constructor(path, options) {
    assert.isString(path)
    assert.notLengthOf(path, 0)

    this.path = path
    this.parent = options.parent || null
    this.element = options.element
    this.components = options.components ? parseComponents(options.components) : {}

    this.refs = options.refs ? parseRefs(options.refs, this.element) : {}
    this.props = options.props || {}
    if (options.exported) {
      this.script = null
      this.exported = options.exported
    } else {
      this.script = new Script(this, options.script)
      this.exported = this.script.exported
    }

    this.inputs = mapToTypes(TextInput, options.textInputs, this)
      .concat(mapToTypes(PropInput, options.propInputs, this))
    this.conditions = mapToTypes(Condition, options.conditions, this)
    this.iterators = mapToTypes(Iterator, options.iterators, this)
    this.logs = mapToTypes(Log, options.logs, this)
    this.style = options.style || {}
    this.styleItems = mapToTypes(StyleItem, options.styleItems, this)
    this.target = options.target ? new Target(this, options.target) : null
    this.uses = mapToTypes(Use, options.uses, this)

    this.context = null
    this.rendered = false

    this[componentsPool] = {}
    this[renderProps] = null
    this[renderOnPropsChange] = null
    this[renderSourceElement] = null
    this[renderListeners] = null

    this.uid = utils.uid()
    Object.seal(this)

    if (this.script) this.script.afterCreate()

    if (process.env.NODE_ENV === 'development') {
      saveInstance(this)
    }
  }

  [getComponentGenerator](name) {
    const { components } = this
    if (components[name]) return components[name]
    return name.split(':').reduce((object, namePart) => object && object[namePart], components)
  }

  [callRenderListener](name, arg1, arg2) {
    const listeners = this[renderListeners]
    if (listeners && typeof listeners[name] === 'function') {
      listeners[name](arg1, arg2)
    }
  }

  getComponent(name) {
    const generator = this[getComponentGenerator](name)
    if (!generator) return this.parent ? this.parent.getComponent(name) : null
    const pool = this[componentsPool][name]
    if (pool && pool.length > 0) return pool.pop()
    return generator({ parent: this })
  }

  returnComponent(name, component) {
    if (!this[getComponentGenerator](name)) {
      if (this.parent) this.parent.returnComponent(name, component)
      else throw new Error('Unknown component given to return')
    }
    if (!this[componentsPool][name]) this[componentsPool][name] = []
    assert.notOk(component.rendered, 'Cannot return rendered component')
    this[componentsPool][name].push(component)
  }

  reloadProp(name) {
    if (isInternalProp(name)) return
    if (!this.props[name]) {
      log.warn(`Trying to set unknown \`${name}\` prop on component \`${this.path}\``)
      return
    }
    this.exported[name] = this[renderProps][name]
  }

  setRef(ref, value) {
    if (!value) return
    const oldValue = this.refs[ref]
    if (oldValue) this[callRenderListener]('refDelete', ref, oldValue)
    this.refs[ref] = value
    this[callRenderListener]('refSet', ref, value)
    this.exported.emit('onRefsChange')
  }

  deleteRef(ref) {
    const oldValue = this.refs[ref]
    delete this.refs[ref]
    this[callRenderListener]('refDelete', ref, oldValue)
    this.exported.emit('onRefsChange')
  }

  render({
    context = null, props = null, onPropsChange, sourceElement = null,
    listeners = null,
  } = {}) {
    assert.notOk(this.rendered, 'Document is already rendered')

    if (this.context !== context) {
      this.context = context
      this.exported.emit('onContextChange')
    }

    if (typeof props === 'object' && props !== null) {
      this[renderProps] = props
      Object.keys(props).forEach(this.reloadProp, this)
    }

    if (onPropsChange && typeof onPropsChange.connect === 'function') {
      this[renderOnPropsChange] = onPropsChange
      onPropsChange.connect(this.reloadProp, this)
    }

    this[renderSourceElement] = sourceElement
    this[renderListeners] = listeners
    if (this.script) this.script.beforeRender()
    this.inputs.forEach(input => input.render())
    this.conditions.forEach(condition => condition.render())
    this.uses.forEach(use => use.render())
    this.iterators.forEach(iterator => iterator.render())
    if (this.target) this.target.render(sourceElement)
    this.styleItems.forEach(styleItem => styleItem.render())
    this.logs.forEach(docLog => docLog.render())

    this.rendered = true
    if (this.script) this.script.afterRender()
  }

  revert() {
    assert.ok(this.rendered, 'Document is not rendered')
    if (this.script) this.script.beforeRevert()
    this[renderProps] = null
    if (this[renderOnPropsChange]) {
      this[renderOnPropsChange].disconnect(this.reloadProp, this)
      this[renderOnPropsChange] = null
    }
    this[renderSourceElement] = null
    this.inputs.forEach(input => input.revert())
    this.conditions.forEach(condition => condition.revert())
    this.uses.forEach(use => use.revert())
    this.iterators.forEach(iterator => iterator.revert())
    if (this.target) this.target.revert()
    this.styleItems.forEach(styleItem => styleItem.revert())
    this.rendered = false
    if (this.script) this.script.afterRevert()
    this[renderListeners] = null
  }
}

Document.prototype.render = eventLoop.bindInLock(Document.prototype.render)
Document.prototype.revert = eventLoop.bindInLock(Document.prototype.revert)

if (process.env.NODE_ENV === 'development') {
  Document.reload = (path, options) => {
    const documents = instances[path]
    if (documents) {
      eventLoop.callInLock(() => {
        documents.forEach(document => document.reload(options))
      })
    }
  }

  Document.prototype.reload = function (options) {
    const { rendered, context } = this
    const props = this[renderProps]
    const onPropsChange = this[renderOnPropsChange]
    const sourceElement = this[renderSourceElement]

    if (rendered) this.revert()

    const newComponents = options.components ? parseComponents(options.components) : {}
    this.components = Object.assign(this.components, newComponents)
    this[componentsPool] = {}

    if (rendered) {
      this.render({
        context, props, onPropsChange, sourceElement,
      })
    }
  }

  Document.prototype.reload = eventLoop.bindInLock(Document.prototype.reload)
}

module.exports = Document
