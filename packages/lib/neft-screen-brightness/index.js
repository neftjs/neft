const { util, SignalDispatcher, NativeClientBinding } = require('@neft/core')

const { callNativeFunction, onNativeEvent } = new NativeClientBinding('ScreenBrightness')

let brightness
util.defineProperty(exports, 'brightness', null, () => brightness, (val) => {
  callNativeFunction('setBrightness', Math.min(1, Math.max(0, Number(val))))
})
exports.onBrightnessChange = new SignalDispatcher()
callNativeFunction('getBrightness')
onNativeEvent('brightness', (newBrightness) => {
  const oldBrightness = brightness
  brightness = newBrightness
  exports.onBrightnessChange.emit(oldBrightness)
})
