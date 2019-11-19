const log = require('../log')
const assert = require('../assert')
const eventLoop = require('../event-loop')

const { hasOwnProperty } = Object.prototype

class Use {
  constructor(document, element) {
    this.document = document
    this.element = document.element.getChildByAccessPath(element)

    this.name = ''
    this.refName = ''
    this.component = null

    this.hiddenDepth = 0
    this.immediateRenderPending = false
    this.onElementPropsChange = this.element.onPropsChange.asSignalDispatcher()

    this.element.onPropsChange.connect(this.handleElementPropsChange, this)

    let anyElement = this.element
    while (anyElement) {
      const anyElementProps = anyElement.props
      if (hasOwnProperty.call(anyElementProps, 'n-if') || hasOwnProperty.call(anyElementProps, 'n-else')) {
        anyElement.onVisibleChange.connect(this.handleElementVisibleChange, this)
      }
      anyElement = anyElement.parent
    }
  }

  handleElementVisibleChange(oldValue) {
    const value = !oldValue
    const hiddenInc = value ? -1 : 1
    this.hiddenDepth += hiddenInc
    if (this.document.rendered && !this.component && this.hiddenDepth === 0) {
      this.renderImmediate()
    } else if (this.document.rendered && this.component && this.hiddenDepth > 0) {
      this.revert()
    }
  }

  handleElementPropsChange(propName) {
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
    assert.notOk(this.component, '<n-use /> is already rendered')
    if (this.hiddenDepth > 0) return

    const name = this.element.props['n-component']
    if (!name) return
    const component = this.document.getComponent(name)
    if (!component) {
      log.warning(`Cannot find ${name} component to render`)
      return
    }

    component.element.parent = this.element
    component.render({
      context: this.document.context,
      props: this.element.props,
      onPropsChange: this.onElementPropsChange,
      sourceElement: this.element,
    })

    this.name = name
    this.refName = this.element.props['n-ref'] || this.element.props.ref
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
