/* eslint-disable no-console */
const utils = require('../util')
const eventLoop = require('../event-loop')
const { Text } = require('./element')

const listenOnTextChange = function (element, log) {
  if (element instanceof Text) {
    element.onTextChange.connect(log.renderOnChange, log)
  } else {
    element.children.forEach(child => listenOnTextChange(child, log))
  }
}

class Log {
  constructor(document, element) {
    this.document = document
    this.element = document.element.getChildByAccessPath(element)

    this.isRenderPending = false
    this.log = utils.bindFunctionContext(this.log, this)
    this.element.onPropsChange.connect(this.renderOnChange, this)
    listenOnTextChange(this.element, this)
  }

  renderOnChange() {
    if (this.document.rendered) {
      this.render()
    }
  }

  render() {
    if (!this.isRenderPending) {
      this.isRenderPending = true
      eventLoop.setImmediate(this.log)
    }
  }

  log() {
    this.isRenderPending = false
    if (utils.isEmpty(this.element.props)) {
      console.log(this.element.stringifyChildren())
    } else {
      const { props } = this.element
      const log = []
      const content = this.element.stringifyChildren()
      if (content) {
        log.push(content)
      }
      Object.entries(props).forEach(([key, value]) => {
        log.push(key, '=', value)
      })
      console.log(...log)
    }
  }
}

module.exports = Log
