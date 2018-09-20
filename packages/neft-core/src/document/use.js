const signal = require('../signal')
const log = require('../log')
const assert = require('../assert')
const eventLoop = require('../event-loop')

class Use {
  constructor(document, element) {
    this.document = document
    this.element = document.element.getChildByAccessPath(element)

    this.name = ''
    this.refName = ''
    this.component = null

    this.hiddenDepth = 0
    this.immediateRenderPending = false
    this.onElementPropsChange = signal.createReference(this.element.onPropsChange)

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
    if (this.document.rendered && !this.component && this.hiddenDepth === 0) {
      this.renderImmediate()
    } else if (this.document.rendered && this.component && this.hiddenDepth > 0) {
      this.revert()
    }
  }

  whenElementPropsChange(propName) {
    if (propName !== 'n-component') return
    if (!this.document.rendered) return
    this.revert()
    this.renderImmediate()
  }

  renderImmediate() {
    if (this.immediateRenderPending) return
    this.immediateRenderPending = true
    eventLoop.setImmediate(() => {
      this.immediateRenderPending = false
      if (this.document.rendered && !this.component) this.render()
    })
  }

  render() {
    assert.notOk(this.component, 'Use is already rendered')
    if (this.hiddenDepth > 0) return

    const name = this.element.props['n-component']
    const component = this.document.getComponent(name)
    if (!component) {
      log.warning(`Cannot find ${name} component to render`)
      return
    }

    component.render({
      context: this.document.context,
      props: this.element.props,
      onPropsChange: this.onElementPropsChange,
      sourceElement: this.element,
    })
    component.element.parent = this.element

    this.name = name
    this.refName = this.element.props['n-ref']
    this.component = component

    if (this.refName) {
      this.document.setRef(this.refName, component.exported)
    }
  }

  revert() {
    if (!this.component) return
    this.component.revert()
    this.component.element.parent = null
    this.document.returnComponent(this.name, this.component)
    if (this.refName) {
      this.document.deleteRef(this.refName)
    }
    this.name = ''
    this.refName = ''
    this.component = null
  }
}

module.exports = Use
