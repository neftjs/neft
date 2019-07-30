const { NativeStyleItem, Renderer } = require('@neft/core')

const { setPropertyValue } = Renderer.itemUtils

class WebView extends NativeStyleItem {}

WebView.__name__ = 'WebView'

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
