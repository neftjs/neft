const { util } = require('@neftio/core')
const { Image, Class, Impl } = require('@neftio/core/src/renderer')

const { Item } = Impl.Types

exports.create = function (data) {
  Item.create.call(this, data)
  Item.setItemClip.call(this, true)

  // auto size
  data.autoSizeClass = Class.New()
  data.autoSizeClass.target = this
  data.autoSizeClass.priority = -2

  // inner image
  data.image = Image.New()
  Item.setItemParent.call(data.image, this)
  data.image.onLoad(() => {
    exports.setSpriteImageFrameCount.call(this, this._impl.frameCount)
    data.autoSizeClass.running = false
    data.autoSizeClass.changes.setAttribute('height', data.image.height)
    data.autoSizeClass.running = true
  })

  // animation
  this.animation.target = data.image
  this.animation.property = 'x'
  this.animation.easing = 'Steps'
}

exports.createData = function () {
  return util.merge({
    autoSizeClass: null,
    frameCount: 1,
    image: null,
  }, Item.DATA)
}

exports.setSpriteImageSource = function (val) {
  this._impl.image.source = val
}

exports.setSpriteImageFrameCount = function (val) {
  const { width } = this._impl.image
  this._impl.frameCount = val

  this.animation.easing.steps = val
  this.animation.to = -width + width / val

  this._impl.autoSizeClass.running = false
  this._impl.autoSizeClass.changes.setAttribute('width', width / val)
  this._impl.autoSizeClass.running = true
}
