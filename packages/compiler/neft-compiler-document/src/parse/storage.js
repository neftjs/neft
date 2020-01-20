const { Element } = require('@neft/core')

const parse = require('./input-parser')
const { isBinding } = require('./storage-util')

const { Tag, Text } = Element

const OMIT_TAGS = new Set(['style'])

module.exports = function (rootElement, parser) {
  const textInputs = []
  const propInputs = []

  const forElement = (element) => {
    // text
    if (element instanceof Text) {
      const { text } = element
      if (isBinding(text)) {
        const interpolation = parse(text)
        if (interpolation) {
          textInputs.push({ element, interpolation, text })
          element.text = ''
        }
      }
    // props
    } else if (element instanceof Tag && !OMIT_TAGS.has(element.name)) {
      const { props, children } = element

      Object.keys(props).forEach((prop) => {
        const text = props[prop]
        if (isBinding(text)) {
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
