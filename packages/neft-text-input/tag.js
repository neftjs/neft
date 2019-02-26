const { CustomTag } = require('@neft/core')

class TextInputTag extends CustomTag {}

TextInputTag.registerAs('input')

TextInputTag.defineProperty({
  name: 'value',
  defaultValue: '',
})

TextInputTag.defineProperty({
  name: 'placeholder',
  defaultValue: '',
})

TextInputTag.defineProperty({
  name: 'keyboardType',
  defaultValue: '',
})

TextInputTag.defineProperty({
  name: 'multiline',
  defaultValue: false,
})

TextInputTag.defineProperty({
  name: 'returnKeyType',
  defaultValue: '',
})

TextInputTag.defineProperty({
  name: 'secureTextEntry',
  defaultValue: false,
})

module.exports = TextInputTag
