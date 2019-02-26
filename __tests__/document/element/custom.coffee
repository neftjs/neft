Element = require '@neft/core/src/document/element'

{util} = require('@neft/core')

fromHTML = require '@neft/webpack-loader/xhtml-parser'

class CustomInput extends Element.Tag.CustomTag
    @registerAs 'custom-input'

    @defineProperty
        name: 'value'
        defaultValue: ''

it 'creates instances of registered custom tags', ->
    html = fromHTML '<custom-input />'
    assert.instanceOf html.children[0], CustomInput

it 'defined properties have getters and setters', ->
    html = fromHTML '<custom-input />'
    input = html.children[0]
    assert.is input.value, ''
    input.value = 'ab'
    assert.is input.value, 'ab'

it 'defined properties emits change signals', ->
    html = fromHTML '<custom-input />'
    input = html.children[0]
    args = []
    values = []
    input.onValueChange.connect (signalArgs...) ->
        args.push signalArgs
        values.push @value
    input.value = 'ab'
    assert.isEqual args, [['', undefined]]
    assert.isEqual values, ['ab']

it 'defined property is synchronized with prop changes', ->
    html = fromHTML '<custom-input value="a" />'
    input = html.children[0]
    assert.is input.value, 'a'
    input.props.set 'value', 'b'
    assert.is input.value, 'b'

it 'defined property value does not change props', ->
    html = fromHTML '<custom-input value="a" />'
    input = html.children[0]
    input.value = 'b'
    assert.is input.props.value, 'a'

it 'values stays after json parsing', ->
    html = fromHTML '<custom-input />'
    input = html.children[0]
    input.value = 'a'
    assert.is Element.fromJSON(input.toJSON()).value, 'a'
