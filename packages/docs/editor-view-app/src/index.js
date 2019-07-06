/* global window */

import { render } from '@neft/core'
import NativeApp from './components/NativeApp'
import renderFromCode from '~/src/lib/render-from-code'

// for browser we put app inside an iframe
if (process.env.NEFT_BROWSER) {
  window.onmessage = (event) => {
    renderFromCode(event.data)
  }
} else {
  render(NativeApp)
}
