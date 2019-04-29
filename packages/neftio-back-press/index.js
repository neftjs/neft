const { SignalDispatcher, callNativeFunction, onNativeEvent } = require('@neftio/core')

exports.onBackPress = new SignalDispatcher()

exports.killApp = () => callNativeFunction('extensionBackKillApp')

if (process.env.NEFT_NATIVE) {
  onNativeEvent('extensionBackOnBackPress', () => {
    exports.onBackPress.emit()
  })
}
