const Renderer = require('@neft/core/src/renderer')
require('./tag')

const { Impl } = Renderer

class TextInput extends Renderer.Native {
  focus() {
    this.call('focus')
  }
}

TextInput.Initialize = (item) => {
  item.on('valueChange', function (value) {
    this.element.value = value
  })
}

TextInput.defineElementProperty({
  name: 'value',
})

TextInput.defineProperty({
  type: 'color',
  name: 'textColor',
})

TextInput.defineElementProperty({
  name: 'placeholder',
})

TextInput.defineProperty({
  type: 'color',
  name: 'placeholderColor',
})

// text, numeric, email, tel
TextInput.defineElementProperty({
  name: 'keyboardType',
  implementationValue: val => val && val.toLowerCase(),
})

TextInput.defineElementProperty({
  name: 'multiline',
})

// done, go, next, search, send, null
TextInput.defineElementProperty({
  name: 'returnKeyType',
  implementationValue: val => val && val.toLowerCase(),
})

TextInput.defineElementProperty({
  name: 'secureTextEntry',
})

if (process.env.NEFT_HTML) {
  Impl.addTypeImplementation('TextInput', require('./impl/css/textInput'))
}

module.exports = TextInput
