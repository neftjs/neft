class Condition {
  constructor(document, { element, elseElement }) {
    this.document = document
    this.element = document.element.getChildByAccessPath(element)
    this.elseElement = elseElement && document.element.getChildByAccessPath(elseElement)

    this.element.onPropsChange.connect(this.onPropsChange, this)
  }

  onPropsChange(name) {
    if (name === 'n-if') {
      this.update()
    }
  }

  update() {
    const { element, elseElement } = this
    const visible = !!element.props['n-if']
    element.visible = visible
    if (elseElement) {
      elseElement.visible = !visible
    }
  }

  render() {
    this.update()
  }

  revert() {
    // NOP
  }
}

module.exports = Condition
