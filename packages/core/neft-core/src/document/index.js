const util = require('../util')
const assert = require('../assert')
const eventLoop = require('../event-loop')
const Renderer = require('../renderer')
const log = require('../log')
const Use = require('./use')
const Log = require('./log')
const Condition = require('./condition')
const TextInput = require('./input/text')
const PropInput = require('./input/prop')
const Script = require('./script')
const Slot = require('./slot')
const Iterator = require('./iterator')
const StyleItem = require('./style-item')

const parseImports = (imports) => {
  Object.keys(imports).forEach((name) => {
    const file = imports[name]
    if (typeof file === 'object' && file != null) {
      imports[name] = file.default
    }
  })
  return imports
}

const parseRefs = (refs, element) => Object.create(Object.keys(refs).reduce((result, key) => {
  result[key] = element.getChildByAccessPath(refs[key])
  return result
}, {}))

const mapToTypes = (Type, list, document) => {
  if (list) return list.map(opts => new Type(document, opts))
  return []
}

const createInitLocalPool = (components) => {
  const pool = {}
  Object.keys(components).forEach((key) => {
    pool[key] = []
  })
  return pool
}

const isInternalProp = prop => (prop[0] === 'n' && prop[1] === '-') || prop === 'ref'

const attachStyles = (styles, element) => {
  Object.values(styles).forEach((style) => {
    const { selects } = style
    if (!selects) return
    selects.forEach((selectGen) => {
      const { select } = selectGen()
      select.target = new Renderer.Class.ElementTarget(element)
      select.running = true
    })
  })
}

const documents = Object.create(null)
const globalPool = Object.create(null)
const localPool = Symbol('localPool')
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
  constructor(path, config, options) {
    assert.isString(path)
    assert.notLengthOf(path, 0)

    this.path = path
    this.parent = (options && options.parent) || null
    this.element = config.element
    this.imports = config.imports ? parseImports(config.imports) : {}
    this.components = config.components || {}

    this.refs = config.refs ? parseRefs(config.refs, this.element) : {}
    this.props = config.props || {}
    this.script = new Script(this, config.script)
    this.exported = null
    this.root = options && options.root != null ? options.root : true

    this.inputs = mapToTypes(TextInput, config.textInputs, this)
      .concat(mapToTypes(PropInput, config.propInputs, this))
    this.conditions = mapToTypes(Condition, config.conditions, this)
    this.iterators = mapToTypes(Iterator, config.iterators, this)
    this.logs = mapToTypes(Log, config.logs, this)
    this.style = config.style || {}
    this.styleItems = mapToTypes(StyleItem, config.styleItems, this)
    this.slot = config.slot ? new Slot(this, config.slot) : null
    this.uses = mapToTypes(Use, config.uses, this)

    this.context = null
    this.rendered = false

    this[localPool] = createInitLocalPool(this.components)
    this[renderProps] = null
    this[renderOnPropsChange] = null
    this[renderSourceElement] = null
    this[renderListeners] = null

    this.uid = util.uid()
    Object.seal(this)

    if (process.env.NODE_ENV === 'development') {
      saveInstance(this)
    }

    attachStyles(this.style, this.element)
  }

  [callRenderListener](name, arg1, arg2) {
    const listeners = this[renderListeners]
    if (listeners && typeof listeners[name] === 'function') {
      listeners[name](arg1, arg2)
    }
  }

  getComponent(name) {
    const imported = this.imports[name] || name
    if (imported) {
      const pool = globalPool[imported]
      if (pool) {
        if (pool.length > 0) return pool.pop()
        return documents[imported].constructor()
      }
    }

    const local = this.components[name]
    if (local) {
      const pool = this[localPool][name]
      if (pool) {
        if (pool.length > 0) return pool.pop()
        return local({ parent: this })
      }
    }

    return this.parent ? this.parent.getComponent(name) : null
  }

  returnComponent(name, component) {
    assert.notOk(component.rendered, 'Cannot return rendered component')

    const imported = this.imports[name] || name
    if (imported) {
      const pool = globalPool[imported]
      if (pool) {
        pool.push(component)
        return
      }
    }

    const local = this.components[name]
    if (local) {
      this[localPool][name].push(component)
      return
    }

    if (this.parent) {
      this.parent.returnComponent(name, component)
    } else {
      throw new Error('Unknown component given to return')
    }
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
    this.exported.emit('on$RefsChange')
  }

  deleteRef(ref) {
    const oldValue = this.refs[ref]
    delete this.refs[ref]
    this[callRenderListener]('refDelete', ref, oldValue)
    this.exported.emit('on$RefsChange')
  }

  render({
    context = null, props = null, onPropsChange, sourceElement = null,
    listeners = null, exported = null,
  } = {}) {
    assert.notOk(this.rendered, 'Document is already rendered')

    this.exported = exported === null ? this.script.produceExported() : exported
    this.context = context

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
    this.inputs.forEach(input => input.render())
    this.conditions.forEach(condition => condition.render())
    this.uses.forEach(use => use.render())
    this.iterators.forEach(iterator => iterator.render())
    if (this.slot) this.slot.render(sourceElement)
    this.styleItems.forEach(styleItem => styleItem.render())
    this.logs.forEach(docLog => docLog.render())

    this.rendered = true
    if (this.root) this.script.afterRender()
  }

  revert() {
    assert.ok(this.rendered, 'Document is not rendered')
    if (this.root) this.script.beforeRevert()
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
    if (this.slot) this.slot.revert()
    this.styleItems.forEach(styleItem => styleItem.revert())
    this.rendered = false
    this[renderListeners] = null
    this.exported = null
  }
}

Document.prototype.render = eventLoop.bindInLock(Document.prototype.render)
Document.prototype.revert = eventLoop.bindInLock(Document.prototype.revert)

Document.register = (path, constructor, { dependencies }) => {
  documents[path] = { constructor, dependencies }
  globalPool[path] = []
}

Document.getComponentConstructorOf = (path) => {
  const config = documents[path]
  return config ? config.constructor : null
}

if (process.env.NODE_ENV === 'development') {
  Document.reload = (path) => {
    instances[path] = []
    globalPool[path] = []

    Object.keys(documents)
      .filter(docPath => documents[docPath].dependencies.includes(path))
      .forEach((docPath) => {
        instances[docPath]
          .filter(doc => doc.rendered)
          .forEach((doc) => {
            eventLoop.callInLock(() => {
              const { context, exported } = doc
              const props = doc[renderProps]
              const onPropsChange = doc[renderOnPropsChange]
              const sourceElement = doc[renderSourceElement]
              const listeners = doc[renderListeners]
              doc.revert()
              globalPool[path] = []
              doc.render({
                context, props, onPropsChange, sourceElement, listeners, exported,
              })
            })
          })
      })
  }
}

module.exports = Document
