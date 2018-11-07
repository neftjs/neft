const { signal, callNativeFunction, onNativeEvent } = require('@neft/core')

const NATIVE_PREFIX = 'NeftDeepLinking'
const GET_OPEN_URL = `${NATIVE_PREFIX}/getOpenUrl`
const OPEN_URL_CHANGE = `${NATIVE_PREFIX}/openUrlChange`

exports.openUrl = null
exports.onOpenUrlChange = signal.create()

callNativeFunction(GET_OPEN_URL)

onNativeEvent(OPEN_URL_CHANGE, (openUrl) => {
  const old = exports.openUrl
  if (old !== openUrl) {
    exports.openUrl = openUrl
    exports.onOpenUrlChange.emit(old)
  }
})
