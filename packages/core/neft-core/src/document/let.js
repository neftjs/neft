class Let {
  constructor(document, element) {
    this.document = document
    this.element = document.element.getChildByAccessPath(element)
    this.names = Object.keys(this.element.props)

    this.element.onPropsChange.connect(this.handlePropChange, this)
  }

  handlePropChange(prop) {
    if (this.document.rendered) {
      this.document.exported[prop] = this.element.props[prop]
    }
  }

  render() {
    this.names.forEach((name) => {
      this.document.exported[name] = this.element.props[name]
    })
  }
}

module.exports = Let
