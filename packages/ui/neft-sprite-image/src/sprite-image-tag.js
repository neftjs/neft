const { CustomTag } = require('@neft/core')

class SpriteImageTag extends CustomTag {}

SpriteImageTag.registerAs('sprite-img')

SpriteImageTag.defineProperty({
  name: 'src',
  styleName: 'source',
  defaultValue: '',
})

SpriteImageTag.defineProperty({
  name: 'frameCount',
  defaultValue: 1,
})

module.exports = SpriteImageTag
