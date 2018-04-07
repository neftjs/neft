const { signal } = Neft
const { callNativeFunction, onNativeEvent } = Neft.native

exports.onBackPress = signal.create()

exports.killApp = () => callNativeFunction('extensionBackKillApp')

onNativeEvent('extensionBackOnBackPress', () => {
    exports.onBackPress.emit()
})
