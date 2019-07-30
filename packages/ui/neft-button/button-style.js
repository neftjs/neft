const { NativeStyleItem } = require('@neft/core')

class Button extends NativeStyleItem {}

Button.__name__ = 'Button'

Button.defineProperty({
  type: 'text',
  name: 'text',
})

Button.defineProperty({
  type: 'color',
  name: 'textColor',
})

module.exports = Button
