const { Impl, Native } = require('@neft/core/src/renderer')

class Button extends Native {}

Button.defineProperty({
  type: 'text',
  name: 'text',
})

Button.defineProperty({
  type: 'color',
  name: 'textColor',
})

if (process.env.NEFT_HTML) {
  Impl.addTypeImplementation('Button', require('./impl/css/button'))
}

module.exports = Button
