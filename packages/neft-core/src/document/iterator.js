const util = require('../util')
const assert = require('../assert')
const eventLoop = require('../event-loop')
const ObservableArray = require('../observable-array')

class Iterator {
  constructor(document, { element, component, naming }) {
    this.document = document
    this.element = document.element.getChildByAccessPath(element)
    this.component = component
    this.naming = naming

    this.data = null
    this.pool = []
    this.usedComponents = []
    this.refs = {}
    this.hiddenDepth = 0
    this.immediateRenderPending = false
    this.componentListeners = {
      refSet: this.setRef.bind(this),
      refDelete: this.deleteRef.bind(this),
    }

    this.element.onPropsChange.connect(this.handleElementPropsChange, this)

    let anyElement = this.element
    while (anyElement) {
      if ('n-if' in anyElement.props) {
        anyElement.onVisibleChange.connect(this.handleElementVisibleChange, this)
      }
      anyElement = anyElement.parent
    }
  }

  handleElementVisibleChange(oldValue) {
    const value = !oldValue
    const hiddenInc = value ? -1 : 1
    this.hiddenDepth += hiddenInc
    if (this.document.rendered && this.data === null && this.hiddenDepth === 0) {
      this.renderImmediate()
    } else if (this.document.rendered && this.data !== null && this.hiddenDepth > 0) {
      this.revert()
    }
  }

  handleElementPropsChange(propName) {
    if (propName !== 'n-for') return
    if (!this.document.rendered) return
    this.revert()
    this.renderImmediate()
  }

  setRef(name, value) {
    let array = this.document.refs[name]
    if (!array) {
      array = new ObservableArray()
      this.document.setRef(name, array)
    }
    array.push(value)
  }

  deleteRef(name, value) {
    const array = this.document.refs[name]
    if (Array.isArray(array)) {
      util.remove(array, value)
    }
  }

  forEachComponentBaseRef(component, func) {
    const refs = Object.getPrototypeOf(component.refs)
    Object.keys(refs).forEach((ref) => { this[func](ref, refs[ref]) })
  }

  renderImmediate() {
    if (this.immediateRenderPending) return
    this.immediateRenderPending = true
    eventLoop.setImmediate(() => {
      this.immediateRenderPending = false
      if (this.document.rendered && !this.data) this.render()
    })
  }

  render() {
    if (this.hiddenDepth > 0) return
    const data = this.element.props['n-for']

    // stop if nothing changed
    if (data === this.data) return

    // stop if no data found
    if (!Array.isArray(data)) return

    // set as data
    this.data = data

    // listen on changes
    if (data instanceof ObservableArray) {
      data.onPush.connect(this.insertItem, this)
      data.onPop.connect(this.popItem, this)
    }

    // add items
    data.forEach(this.insertItem, this)
  }

  revert() {
    const { data } = this
    if (data) {
      this.popAllItems()
      if (data instanceof ObservableArray) {
        data.onPush.disconnect(this.insertItem, this)
        data.onPop.disconnect(this.popItem, this)
      }
    }
    this.data = null
  }

  updateItem(elem, index = elem) {
    assert.isObject(this.data)
    assert.isInteger(index)
    this.popItem(index)
    this.insertItem(index)
  }

  getComponent() {
    if (this.pool.length) return this.pool.pop()
    const component = this.component({
      parent: this.document,
      root: false,
    })
    return component
  }

  insertItem(elem, index = elem) {
    assert.isObject(this.data)
    assert.isInteger(index)

    const { data, naming } = this
    const usedComponent = this.getComponent()
    const exported = Object.create(this.document.exported)

    this.usedComponents.splice(index, 0, usedComponent)

    if (naming.item) exported[naming.item] = data[index]
    if (naming.index) exported[naming.index] = index
    if (naming.array) exported[naming.array] = data

    const newChild = usedComponent.element
    newChild.parent = this.element
    newChild.index = index
    this.forEachComponentBaseRef(usedComponent, 'setRef')
    usedComponent.render({
      exported,
      context: this.document.context,
      listeners: this.componentListeners,
    })
  }

  popItem(elem, index = elem) {
    assert.isObject(this.data)
    assert.isInteger(index)
    const usedComponent = this.usedComponents[index]
    this.forEachComponentBaseRef(usedComponent, 'deleteRef')
    usedComponent.revert()
    usedComponent.element.parent = null
    this.pool.push(usedComponent)
    this.usedComponents.splice(index, 1)
  }

  popAllItems() {
    assert.isObject(this.data)
    while (this.usedComponents.length) {
      this.popItem(this.usedComponents.length - 1)
    }
  }
}

module.exports = Iterator
