const { util, SignalDispatcher } = require('@neft/core')
const Renderer = require('@neft/core/src/renderer')

const { Item } = Renderer.Impl.Types

exports.create = function (data) {
  Item.create.call(this, data)

  const innerElem = document.createElement('input')
  data.innerElem = innerElem
  innerElem.setAttribute('type', 'text')
  data.innerElemStyle = innerElem.style
  data.elem.appendChild(innerElem)

  innerElem.addEventListener('input', () => {
    data.onValueChange.emit(innerElem.value)
  })
}

exports.createData = function () {
  return util.merge({
    innerElem: null,
    innerElemStyle: null,
    onValueChange: new SignalDispatcher(),
  }, Item.DATA)
}

exports.setTextInputValue = function (val) {
  this._impl.innerElem.value = val
}

exports.setTextInputPlaceholder = function (val) {
  this._impl.innerElem.placeholder = val
}

exports.setTextInputTextColor = function (val) {
  this._impl.innerElemStyle.color = val
}
