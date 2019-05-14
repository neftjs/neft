// when=NEFT_HTML

const { Item, Native } = require('@neftio/core/src/renderer').Impl.Types

exports.create = function (data) {
  data.elem = document.createElement('button')
  Item.create.call(this, data)
}

exports.createData = function () {
  return Item.createData()
}

exports.setButtonText = function (val) {
  this._impl.elem.textContent = val
  Native.updateNativeSize.call(this)
}

exports.setButtonTextColor = function (val) {
  this._impl.elemStyle.color = val
}
