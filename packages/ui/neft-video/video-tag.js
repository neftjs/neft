const { CustomTag } = require('@neft/core')

class VideoTag extends CustomTag {}

VideoTag.registerAs('video')

VideoTag.defineStyleProperty({
  name: 'src',
  styleName: 'source',
})

VideoTag.defineStyleProperty({
  name: 'loop',
})

module.exports = VideoTag
