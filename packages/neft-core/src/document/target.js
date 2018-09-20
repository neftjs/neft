class Target {
  constructor(document, element) {
    this.document = document
    this.element = document.element.getChildByAccessPath(element)
    this.sourceElement = null
  }

  render(sourceElement) {
    if (!sourceElement) return
    this.sourceElement = sourceElement
    sourceElement.children.forEach((child) => {
      child.parent = this.element
    })
  }

  revert() {
    if (!this.sourceElement) return
    this.element.children.forEach((child) => {
      child.parent = this.sourceElement
    })
    this.sourceElement = null
  }
}

module.exports = Target
