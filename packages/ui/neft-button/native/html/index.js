/* global document */
const { Renderer: { Impl } } = require('@neft/core')

const { Item: ItemImpl, Native: NativeImpl } = Impl.Types

exports.create = function (data) {
  data.elem = document.createElement('button')
  ItemImpl.create.call(this, data)
}

exports.createData = function () {
  return ItemImpl.createData()
}

exports.setButtonText = function (val) {
  this._impl.elem.textContent = val
  NativeImpl.updateNativeSize.call(this)
}

exports.setButtonTextColor = function (val) {
  this._impl.elemStyle.color = val
}

Impl.addTypeImplementation('Button', exports)
