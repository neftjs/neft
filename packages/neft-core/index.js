const { callNativeFunction, onNativeEvent } = process.env.NEFT_NATIVE ? require('./src/native') : {}

exports.callNativeFunction = callNativeFunction
exports.onNativeEvent = onNativeEvent

exports.util = require('./src/util')
exports.signal = require('./src/signal')
exports.Struct = require('./src/struct')
exports.ObservableArray = require('./src/observable-array')

const Renderer = require('./src/renderer')

const windowItem = Renderer.Flow.New()
Renderer.setWindowItem(windowItem)

exports.attach = (document) => {
  while (windowItem.children.lastChild) {
    windowItem.children.lastChild.parent = null
  }
  document.styleItems.forEach((styleItem) => {
    styleItem.item.parent = windowItem
  })
}
