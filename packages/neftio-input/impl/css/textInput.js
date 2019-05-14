const { util, SignalDispatcher } = require('@neftio/core')
const Renderer = require('@neftio/core/src/renderer')

const { Item } = Renderer.Impl.Types

exports.create = function (data) {
  Item.create.call(this, data)

  const innerElem = document.createElement('input')
  data.innerElem = innerElem
  innerElem.setAttribute('type', 'text')
  data.innerElemStyle = innerElem.style
  data.elem.appendChild(innerElem)

  innerElem.addEventListener('input', () => {
    data.onTextChange.emit(innerElem.value)
  })
}

exports.createData = function () {
  return util.merge({
    innerElem: null,
    innerElemStyle: null,
    onTextChange: new SignalDispatcher(),
  }, Item.DATA)
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
