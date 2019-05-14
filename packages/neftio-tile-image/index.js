const { NativeStyleItem } = require('@neftio/core')

class TileImage extends NativeStyleItem {}

TileImage.defineProperty({
  type: 'resource',
  name: 'source',
  onResolutionChange(resolution) {
    this.set('resolution', resolution)
  },
})

if (process.env.NEFT_HTML) {
  TileImage.addTypeImplementation(require('./impl/css/tileImage'))
}

module.exports = TileImage
