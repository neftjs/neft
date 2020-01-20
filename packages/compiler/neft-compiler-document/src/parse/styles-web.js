const postcss = require('postcss')
const prefixer = require('postcss-prefixer')
const { Element, util } = require('@neft/core')
const { prefixTagClassOrIdProp } = require('@neft/core/src/document/element/element/tag/util')
const { isBinding } = require('./storage-util')

const PROPS_TO_PREFIX = ['class', 'id']

module.exports = (element, parser) => {
  const uid = `c${util.uid()}`
  parser.addProp('uid', () => `'${uid}'`)

  PROPS_TO_PREFIX.forEach((prop) => {
    element.queryAll(`[${prop}]`).forEach((child) => {
      if (!isBinding(child.props[prop])) {
        child.props.set(prop, prefixTagClassOrIdProp(prop, child.props.class, uid))
      }
    })
  })

  const [docStyle] = element.queryAll('style')
  if (docStyle) {
    const parserStyle = parser.styles[parser.resourcePath]
    const text = docStyle.children[0]
    if (text instanceof Element.Text) {
      const input = parserStyle.value
      const output = postcss([
        prefixer({
          prefix: `${uid}-`,
        }),
      ]).process(input).css
      text.text = output
    }
  }
}
