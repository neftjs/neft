const { SignalDispatcher, NativeClientBinding } = require('@neft/core')

const { callNativeFunction, onNativeEvent } = new NativeClientBinding('DeepLinking')

exports.openUrl = null
exports.onOpenUrlChange = new SignalDispatcher()

callNativeFunction('getOpenUrl')

onNativeEvent('openUrlChange', (openUrl) => {
  const old = exports.openUrl
  if (old !== openUrl) {
    exports.openUrl = openUrl
    exports.onOpenUrlChange.emit(old)
  }
})
