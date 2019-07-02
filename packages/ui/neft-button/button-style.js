const { Renderer: { Native } } = require('@neft/core')

class Button extends Native {}

Button.defineProperty({
  type: 'text',
  name: 'text',
})

Button.defineProperty({
  type: 'color',
  name: 'textColor',
})

module.exports = Button
