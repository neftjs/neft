const { util, SignalDispatcher, NativeClientBinding } = require('@neft/core')

const { callNativeFunction, onNativeEvent } = new NativeClientBinding('FirebaseMessaging')

let deviceToken
util.defineProperty(exports, 'deviceToken', null, () => deviceToken, null)
exports.onDeviceTokenChange = new SignalDispatcher()
callNativeFunction('getToken')
onNativeEvent('token', (newToken) => {
  const oldToken = deviceToken
  deviceToken = newToken
  exports.onDeviceTokenChange.emit(oldToken)
})

exports.onMessageReceived = new SignalDispatcher()
onNativeEvent('messageReceived', (data) => {
  const payload = typeof data === 'string' && data ? JSON.parse(data) : {}
  exports.onMessageReceived.emit(payload)
})

exports.register = () => {
  callNativeFunction('register')
}
