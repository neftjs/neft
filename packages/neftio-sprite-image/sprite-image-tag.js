const { CustomTag } = require('@neftio/core')

class SpriteImageTag extends CustomTag {}

SpriteImageTag.registerAs('sprite-image')

SpriteImageTag.defineProperty({
  name: 'source',
  defaultValue: '',
})

SpriteImageTag.defineProperty({
  name: 'frameCount',
  defaultValue: 1,
})

module.exports = SpriteImageTag
