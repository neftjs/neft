const { Renderer } = require('@neft/core')

const { setPropertyValue } = Renderer.itemUtils

class WebView extends Renderer.Native {}

WebView.Initialize = (item) => {
  item.on('sourceChange', function (value) {
    setPropertyValue(this, 'source', value)
  })
}

WebView.defineProperty({
  type: 'text',
  name: 'source',
})

module.exports = WebView
