const N_PROVIDE_CONTEXT = 'n-provide-context'

class Context {
  constructor(document, element) {
    this.document = document
    this.element = document.element.getChildByAccessPath(element)
    this.name = this.element.props.name
    this.as = this.element.props.as

    this.context = null
  }

  handleContextPropsChange(prop) {
    if (prop === 'value') {
      this.injectContext()
    }
  }

  injectContext() {
    this.document.exported[this.as] = this.context.props.value
  }

  render() {
    const { name } = this
    let { element } = this
    while (element) {
      if (element.name === N_PROVIDE_CONTEXT && element.props.name === name) {
        this.context = element
        element.onPropsChange.connect(this.handleContextPropsChange, this)
        this.injectContext()
        break
      }
      element = element.parent
    }
  }

  revert() {
    const { context } = this

    if (context) {
      context.onPropsChange.disconnect(this.handleContextPropsChange, this)
      this.context = null
      this.document.exported[this.as] = null
    }
  }
}

module.exports = Context
