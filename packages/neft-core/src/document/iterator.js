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
    this.hiddenDepth = 0
    this.immediateRenderPending = false

    this.element.onPropsChange.connect(this.whenElementPropsChange, this)

    let anyElement = this.element
    while (anyElement) {
      if ('n-if' in anyElement.props) {
        anyElement.onVisibleChange.connect(this.whenElementVisibleChange, this)
      }
      anyElement = anyElement.parent
    }
  }

  whenElementVisibleChange(oldValue) {
    const value = !oldValue
    const hiddenInc = value ? -1 : 1
    this.hiddenDepth += hiddenInc
    if (this.document.rendered && this.data === null && this.hiddenDepth === 0) {
      this.renderImmediate()
    } else if (this.document.rendered && this.data !== null && this.hiddenDepth > 0) {
      this.revert()
    }
  }

  whenElementPropsChange(propName) {
    if (propName !== 'n-for') return
    if (!this.document.rendered) return
    this.revert()
    this.renderImmediate()
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
    return this.component({
      parent: this.document,
      exported: Object.create(this.document.exported),
    })
  }

  insertItem(elem, index = elem) {
    assert.isObject(this.data)
    assert.isInteger(index)

    const { data, naming } = this
    const usedComponent = this.getComponent()
    const { exported } = usedComponent

    this.usedComponents.splice(index, 0, usedComponent)

    if (naming.item) exported[naming.item] = data[index]
    if (naming.index) exported[naming.index] = index
    if (naming.array) exported[naming.array] = data

    const newChild = usedComponent.element
    newChild.parent = this.element
    newChild.index = index
    usedComponent.render({ context: this.document.context })
  }

  popItem(elem, index = elem) {
    assert.isObject(this.data)
    assert.isInteger(index)
    const usedComponent = this.usedComponents[index]
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
