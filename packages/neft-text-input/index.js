const Renderer = require('@neft/core/src/renderer')

const { setPropertyValue } = Renderer.itemUtils
const { Impl } = Renderer

class TextInput extends Renderer.Native {
  focus() {
    this.call('focus')
  }
}

TextInput.Initialize = (item) => {
  item.on('textChange', function (val) {
    setPropertyValue(this, 'text', val)
  })
}

TextInput.defineProperty({
  type: 'text',
  name: 'text',
  defaultValue: '',
})

TextInput.defineProperty({
  type: 'color',
  name: 'textColor',
})

TextInput.defineProperty({
  type: 'text',
  name: 'placeholder',
  defaultValue: '',
})

TextInput.defineProperty({
  type: 'color',
  name: 'placeholderColor',
})

// text, numeric, email, tel
TextInput.defineProperty({
  type: 'text',
  name: 'keyboardType',
  implementationValue: val => val && val.toLowerCase(),
})

TextInput.defineProperty({
  type: 'boolean',
  name: 'multiline',
})

// done, go, next, search, send, null
TextInput.defineProperty({
  type: 'text',
  name: 'returnKeyType',
  implementationValue: val => val && val.toLowerCase(),
})

TextInput.defineProperty({
  type: 'boolean',
  name: 'secureTextEntry',
})

if (process.env.NEFT_HTML) {
  Impl.addTypeImplementation('TextInput', require('./impl/css/textInput'))
}

module.exports = TextInput
