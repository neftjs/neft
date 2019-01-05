const { NativeStyleItem } = require('@neft/core')

class Video extends NativeStyleItem {
  start() {
    this.call('start')
  }

  stop() {
    this.call('stop')
  }
}

Video.defineProperty({
  type: 'text',
  name: 'source',
})

Video.defineProperty({
  type: 'boolean',
  name: 'loop',
})

module.exports = Video
