const { signal, callNativeFunction, onNativeEvent } = require('@neft/core')

exports.onBackPress = signal.create()

exports.killApp = () => callNativeFunction('extensionBackKillApp')

onNativeEvent('extensionBackOnBackPress', () => {
  exports.onBackPress.emit()
})
