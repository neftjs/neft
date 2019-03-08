const { CustomTag } = require('@neft/core')

class TextInputTag extends CustomTag {}

TextInputTag.registerAs('input')

TextInputTag.defineStyleProperty({
  name: 'value',
  styleName: 'text',
})

TextInputTag.defineStyleProperty({
  name: 'placeholder',
})

TextInputTag.defineStyleProperty({
  name: 'keyboardType',
})

TextInputTag.defineStyleProperty({
  name: 'multiline',
})

TextInputTag.defineStyleProperty({
  name: 'returnKeyType',
})

TextInputTag.defineStyleProperty({
  name: 'secureTextEntry',
})

module.exports = TextInputTag
