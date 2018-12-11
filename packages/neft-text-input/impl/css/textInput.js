
const { util } = require('@neft/core')
const Renderer = require('@neft/core/src/renderer')

const { setPropertyValue } = Renderer.itemUtils
const { Item } = Renderer.Impl.Types

exports.create = function (data) {
  Item.create.call(this, data)

  const innerElem = data.innerElem = document.createElement('input')
  innerElem.setAttribute('type', 'text')
  data.innerElemStyle = innerElem.style
  data.elem.appendChild(innerElem)

  innerElem.addEventListener('input', () => {
    setPropertyValue(this, 'text', innerElem.value)
  })
}

exports.createData = function () {
  return util.merge({
    innerElem: null,
    innerElemStyle: null,
  }, Item.DATA)
}

exports.setTextInputText = function (val) {
  this._impl.innerElem.value = val
}

exports.setTextInputTextColor = function (val) {
  this._impl.innerElemStyle.color = val
}
