/* global document */
const { util, SignalDispatcher, Renderer } = require('@neft/core')

const { Impl } = Renderer
const { Item: ItemImpl, Native: NativeImpl } = Impl.Types

const DEFAULT_STYLES = {
  width: '100%',
  height: '100%',
  background: 'none',
  border: 'none'
}

exports.create = function (data) {
  ItemImpl.create.call(this, data)

  const innerElem = document.createElement('input')
  data.innerElem = innerElem
  innerElem.setAttribute('type', 'text')
  data.innerElemStyle = innerElem.style
  Object.assign(data.innerElemStyle, DEFAULT_STYLES)
  data.elem.appendChild(innerElem)

  innerElem.addEventListener('input', () => {
    data.onTextChange.emit(innerElem.value)
  })

  NativeImpl.updateNativeSize.call(this)
}

exports.createData = function () {
  return util.merge({
    innerElem: null,
    innerElemStyle: null,
    onTextChange: new SignalDispatcher(),
  }, ItemImpl.DATA)
}

exports.setTextInputText = function (val) {
  this._impl.innerElem.value = val
}

exports.setTextInputPlaceholder = function (val) {
  this._impl.innerElem.placeholder = val
}

exports.setTextInputTextColor = function (val) {
  this._impl.innerElemStyle.color = val
}

Impl.addTypeImplementation('TextInput', exports)
