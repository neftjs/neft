const { signal, callNativeFunction, onNativeEvent } = require('@neft/core')

exports.onBackPress = signal.create()

exports.killApp = () => callNativeFunction('extensionBackKillApp')

if (process.env.NEFT_NATIVE) {
  onNativeEvent('extensionBackOnBackPress', () => {
    exports.onBackPress.emit()
  })
}
