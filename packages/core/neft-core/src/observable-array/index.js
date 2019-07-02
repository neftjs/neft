const { SignalDispatcher } = require('../signal')

class ObservableArray extends Array {
  constructor(elements) {
    super(...elements)
    this.onPush = new SignalDispatcher()
    this.onPop = new SignalDispatcher()
  }

  push(...elements) {
    const result = super.push(...elements)
    elements.forEach((element, index) => {
      this.onPush.emit(element, this.length - elements.length + index)
    })
    return result
  }

  pop() {
    if (this.length === 0) return super.pop()
    const result = super.pop()
    this.onPop.emit(result, this.length)
    return result
  }

  shift() {
    if (this.length === 0) return super.shift()
    const result = super.shift()
    this.onPop.emit(result, 0)
    return result
  }

  unshift(...elements) {
    const result = super.unshift(...elements)
    elements.forEach((element, index) => {
      this.onPush.emit(element, index)
    })
    return result
  }

  splice(start, deleteCount, ...elements) {
    const popped = this.slice(start, start + deleteCount)
    const result = super.splice(start, deleteCount, ...elements)
    popped.forEach((element, index) => {
      this.onPop.emit(element, start + index)
    })
    elements.forEach((element, index) => {
      this.onPush.emit(element, start + index)
    })
    return result
  }

  reverse() {
    this.forEach((element, index) => { this.onPop.emit(element, index) })
    const result = super.reverse()
    this.forEach((element, index) => { this.onPush.emit(element, index) })
    return result
  }

  sort(compareFunction) {
    this.forEach((element, index) => { this.onPop.emit(element, index) })
    const result = super.sort(compareFunction)
    this.forEach((element, index) => { this.onPush.emit(element, index) })
    return result
  }
}

module.exports = ObservableArray
