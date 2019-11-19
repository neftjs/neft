class Slot {
  constructor(document, element) {
    this.document = document
    this.element = document.element.getChildByAccessPath(element)
    this.sourceElement = null
  }

  render(sourceElement) {
    if (!sourceElement) return
    this.sourceElement = sourceElement
    const { children } = sourceElement

    for (let i = 0, n = children.length; i < n; i += 1) {
      const child = children[0]
      if (child !== this.document.element) {
        child.parent = this.element
      }
    }
  }

  revert() {
    if (!this.sourceElement) return
    const { children } = this.element
    for (let i = 0, n = children.length; i < n; i += 1) {
      const child = children[0]
      child.parent = this.sourceElement
    }
    this.sourceElement = null
  }
}

module.exports = Slot
