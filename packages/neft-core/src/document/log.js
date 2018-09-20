const utils = require('../util')
const eventLoop = require('../event-loop')
const { Text } = require('./element')

const listenOnTextChange = function (element, log) {
  if (element instanceof Text) {
    element.onTextChange(log.renderOnChange, log)
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
    this.element.onPropsChange(this.renderOnChange, this)
    listenOnTextChange(this.element, this)
  }

  renderOnChange() {
    if (this.file.isRendered) {
      return this.render()
    }
  }

  render() {
    if (!this.isRenderPending) {
      this.isRenderPending = true
      eventLoop.setImmediate(this.log)
    }
  }

  log() {
    let content; let key; let log; let props; let
      val
    this.isRenderPending = false
    if (utils.isEmpty(this.element.props)) {
      console.log(this.element.stringifyChildren())
    } else {
      ({ props } = this.element)
      log = []
      if (content = this.element.stringifyChildren()) {
        log.push(content)
      }
      for (key in props) {
        val = props[key]
        if (props.hasOwnProperty(key)) {
          log.push(key, '=', val)
        }
      }
      console.log(...log)
    }
  }
}

module.exports = Log
