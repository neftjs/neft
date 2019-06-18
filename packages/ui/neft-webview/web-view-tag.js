const { CustomTag } = require('@neft/core')

class WebViewTag extends CustomTag {}

WebViewTag.registerAs('webview')

WebViewTag.defineStyleProperty({
  name: 'src',
  styleName: 'source',
})

module.exports = WebViewTag
