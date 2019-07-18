/* global window */

import { render, loadFont } from '@neft/core'
import app from './components/app'
import parseStringComponentCode from '~/src/lib/parse-string-component-code'

// for browser we put app inside an iframe
if (process.env.NEFT_BROWSER) {
  window.onmessage = (event) => {
    render(parseStringComponentCode(event.data))
  }
} else {
  const main = async () => {
    await Promise.all([
      loadFont({ name: 'sans-serif', source: 'rsc:/fonts/Lato-Black' }),
      loadFont({ name: 'sans-serif', source: 'rsc:/fonts/Lato-Bold' }),
      loadFont({ name: 'sans-serif', source: 'rsc:/fonts/Lato-Light' }),
      loadFont({ name: 'sans-serif', source: 'rsc:/fonts/Lato-Medium' }),
      loadFont({ name: 'sans-serif', source: 'rsc:/fonts/Lato-Regular' }),
    ])
    render(app)
  }
  main()
}
