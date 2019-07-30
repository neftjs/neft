const { NativeStyleItem } = require('@neft/core')

class TileImage extends NativeStyleItem {}

TileImage.__name__ = 'TileImage'

TileImage.defineProperty({
  type: 'resource',
  name: 'source',
  onResolutionChange(resolution) {
    this.set('resolution', resolution)
  },
})

module.exports = TileImage
