/* global window */

import { render } from '@neft/core'
import '@neft/default-styles/style.nml'

// for browser we put app inside an iframe
if (process.env.NEFT_BROWSER) {
  window.onmessage = (event) => {
    try {
      // eslint-disable-next-line no-new-func
      const body = new Function('module', 'require', event.data)
      const bodyModule = { exports: {} }
      body(bodyModule, require)
      render(bodyModule.exports)
    } catch (error) {
      // NOP
    }
  }
}
