/* global document */
const { util, Renderer: { Impl } } = require('@neft/core')

const { Item } = Impl.Types

exports.create = function (data) {
  data.elem = document.createElement('div')
  Item.create.call(this, data)
  data.elemStyle.backgroundRepeat = 'repeat'
}

exports.createData = function () {
  return util.merge({
    source: '',
    resolution: 1,
  }, Item.DATA)
}

exports.setTileImageSource = function (val) {
  this._impl.source = val
  const img = document.createElement('img')
  img.src = val
  img.addEventListener('load', () => {
    if (this._impl.source !== val) {
      return
    }
    const width = img.width / this._impl.resolution
    this._impl.elemStyle.backgroundImage = `url(${val})`
    this._impl.elemStyle.backgroundSize = `${width}px`
  })
}

exports.setTileImageResolution = function (val) {
  this._impl.resolution = val
}

Impl.addTypeImplementation('TileImage', exports)
