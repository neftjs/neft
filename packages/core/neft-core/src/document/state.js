const VALUE = 'value'

class State {
  constructor(document, element) {
    this.document = document
    this.element = document.element.getChildByAccessPath(element)
    this.name = this.element.props.name

    this.element.onPropsChange.connect(this.handlePropChange, this)
  }

  getValue() {
    return this.element.props.value
  }

  getOnChange() {
    return this.element.props.onChange
  }

  setPropValueOnExported() {
    if (this.element.props.has(VALUE)) {
      this.document.exported[this.name] = this.getValue()
    }
  }

  handlePropChange(prop, oldValue) {
    if (prop === VALUE) {
      const onChange = this.getOnChange()
      this.setPropValueOnExported()
      if (this.document.rendered && typeof onChange === 'function' && this.getValue() !== oldValue) {
        onChange(oldValue)
      }
    }
  }
}

module.exports = State
