const { SignalDispatcher, NativeClientBinding } = require('@neft/core')

const { callNativeFunction, onNativeEvent } = new NativeClientBinding('BackPress')

exports.onBackPress = new SignalDispatcher()

exports.killApp = () => callNativeFunction('killApp')

onNativeEvent('backPress', () => {
  exports.onBackPress.emit()
})
