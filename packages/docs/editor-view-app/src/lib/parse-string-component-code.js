import '@neft/core'
import '@neft/active-link'
import '@neft/back-press'
import '@neft/button'
import '@neft/button/style.nml'
import '@neft/deep-linking'
import '@neft/default-styles'
import '@neft/default-styles/style.nml'
import '@neft/input'
import '@neft/input/style.nml'
import '@neft/request'
import '@neft/scrollable'
import '@neft/slider'
import '@neft/sprite-image'
import '@neft/stepper'
import '@neft/storage'
import '@neft/switch'
import '@neft/tile-image'
import '@neft/video'
import '@neft/websocket'
import '@neft/webview'

export default (code) => {
  try {
    // eslint-disable-next-line no-new-func
    const body = new Function('module', 'require', code)
    const bodyModule = { exports: {} }
    body(bodyModule, require)
    return bodyModule.exports
  } catch (error) {
    console.error(error.message)
    // NOP
  }
  return null
}
