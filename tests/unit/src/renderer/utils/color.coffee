'use strict'

{toRGBAHex} = require 'src/renderer/utils/color'

assertHex = (value, expected) ->
    assert.is toRGBAHex(value).toString(16), expected

describe 'Renderer utils/color', ->
    it 'parses 3-digit hexadecimal', ->
        assertHex '#444', '444444ff'
        assertHex '#123', '112233ff'
        assertHex '#abc', 'aabbccff'

    it 'parses 6-digit hexadecimal', ->
        assertHex '#ffffff', 'ffffffff'
        assertHex '#000000', 'ff'
        assertHex '#100000', '100000ff'
        assertHex '#123456', '123456ff'
        assertHex '#abcdef', 'abcdefff'

    it 'parses rgba', ->
        assertHex 'rgba(1,2,3,0.5)', '1020380'
        assertHex 'rgba(100,200,250,0.8)', '64c8facc'
        assertHex 'rgba(100, 200, 250, 0.8)', '64c8facc'
        assertHex 'rgba ( 100, 200, 250, 0.8 )', '64c8facc'
        assertHex 'rgba ( 100, 299, 250, 2.3 )', '64fffaff'
        assertHex 'rgba ( 100, 299, 250, 1 )', '64fffaff'

    it 'parses rgb', ->
        assertHex 'rgb(1,2,3)', '10203ff'
        assertHex 'rgb(100,200,250)', '64c8faff'
        assertHex 'rgb(100, 200, 250)', '64c8faff'
        assertHex 'rgb ( 100, 200, 250 )', '64c8faff'
        assertHex 'rgb ( 100, 299, 250 )', '64fffaff'

    it 'parses hsl', ->
        assertHex 'hsl(1,2%,3%)', '80807ff'
        assertHex 'hsl( 1, 2% , 3% )', '80807ff'
        assertHex 'hsl( 1, 370% , 3% )', 'ffffebff'

    it 'parses hsla', ->
        assertHex 'hsla(1,2%,3%,0.7)', '80807b3'
        assertHex 'hsla( 1, 2% , 3%, 0.8 )', '80807cc'
        assertHex 'hsla( 1, 370% , 3%, 1.2 )', 'ffffebff'

    it 'parses named color', ->
        assertHex 'white', 'ffffffff'
        assertHex 'black', 'ff'
        assertHex 'red', 'ff0000ff'
        assertHex 'green', '8000ff'
        assertHex 'lime', 'ff00ff'
        assertHex 'blue', 'ffff'
        assertHex 'tomato', 'ff6347ff'
        assertHex 'transparent', '0'

    it 'returns transparent for unknown color', ->
        assertHex '123', '0'
        assertHex ' ', '0'
        assertHex '', '0'

    it 'returns parsed default color for unknown color', ->
        assert.is toRGBAHex('123', 'red').toString(16), 'ff0000ff'

    it 'returns transparent for unknown default color', ->
        assert.is toRGBAHex('123', ' ').toString(16), '0'
