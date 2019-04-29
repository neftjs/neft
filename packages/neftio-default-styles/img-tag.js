const { CustomTag } = require('@neftio/core')

class ImgTag extends CustomTag {}

ImgTag.registerAs('img')

ImgTag.defineStyleProperty({
  name: 'src',
  styleName: 'source',
})

ImgTag.defineStyleProperty({
  name: 'loaded',
})

module.exports = ImgTag
