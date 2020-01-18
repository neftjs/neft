exports.onSetParent = (element, val) => {
  if (val) {
    val.element.appendChild(element.element)
  } else {
    element.element.parentElement.removeChild(element.element)
  }
}

exports.onSetIndex = (element) => {
  if (element.nextSibling) {
    element.parent.element.insertBefore(element.element, element.nextSibling.element)
  } else {
    element.parent.element.appendChild(element.element)
  }
}

exports.onSetVisible = (element, val) => {
  element.element.style.visibility = val ? 'visible' : 'hidden'
}

exports.onSetText = (element) => {
  element.element.data = element.text
}

exports.onSetProp = (element, name, val) => {
  const prop = String(name).toLowerCase()
  if (prop in element.element) {
    element.element[prop] = val
  } else {
    element.element.setAttribute(name, val)
  }
}
