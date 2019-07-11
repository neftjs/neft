const { CustomTag } = require('@neft/core')

class InputTag extends CustomTag {}

InputTag.registerAs('input')

InputTag.defineStyleProperty({
  name: 'value',
  styleName: 'text',
})

InputTag.defineStyleProperty({
  name: 'placeholder',
})

InputTag.defineStyleProperty({
  name: 'keyboardType',
})

InputTag.defineStyleProperty({
  name: 'multiline',
})

InputTag.defineStyleProperty({
  name: 'returnKeyType',
})

InputTag.defineStyleProperty({
  name: 'secureTextEntry',
})

module.exports = InputTag
