const Element = require('@neft/core/src/document/element')

const parse = require('./input-parser')

const { Tag, Text } = Element

const InputRE = /{([^}]*)}/g

const testInput = (text) => {
  InputRE.lastIndex = 0
  return text && InputRE.test(text)
}

module.exports = function (rootElement, parser) {
  const textInputs = []
  const propInputs = []

  const forElement = (element) => {
    // text
    if (element instanceof Text) {
      const { text } = element
      if (testInput(text)) {
        const interpolation = parse(text)
        if (interpolation) {
          textInputs.push({ element, interpolation, text })
          element.text = ''
        }
      }
    // props
    } else if (element instanceof Tag) {
      const { props, children } = element

      Object.keys(props).forEach((prop) => {
        const text = props[prop]
        if (testInput(text)) {
          const interpolation = parse(text)
          props.set(prop, null)
          const pushWay = prop[0] === 'n' && prop[1] === '-' ? 'unshift' : 'push'
          propInputs[pushWay]({
            element, prop, interpolation, text,
          })
        }
      })

      children.forEach(forElement)
    }
  }

  forElement(rootElement)

  const stringify = list => JSON.stringify(list.map(({ element, ...rest }) => ({
    element: element.getAccessPath(rootElement),
    ...rest,
  })))

  if (textInputs.length) {
    parser.addProp('textInputs', () => stringify(textInputs))
  }

  if (propInputs.length) {
    parser.addProp('propInputs', () => stringify(propInputs))
  }
}
