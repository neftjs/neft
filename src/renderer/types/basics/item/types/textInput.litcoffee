# TextInput

    'use strict'

    assert = require 'src/assert'
    utils = require 'src/utils'
    signal = require 'src/signal'
    log = require 'src/log'

    log = log.scope 'Renderer', 'TextInput'

# **Class** TextInput : *Item*

    module.exports = (Renderer, Impl, itemUtils) ->

        class TextInput extends Renderer.Item
            @__name__ = 'TextInput'
            @__path__ = 'Renderer.TextInput'

## *TextInput* TextInput.New([*Component* component, *Object* options])

            @New = (component, opts) ->
                item = new TextInput
                itemUtils.Object.initialize item, component, opts

                # set default font family
                if name = Renderer.FontLoader.getInternalFontName('sans-serif', 0.4, false)
                    Impl.setTextInputFontFamily.call item, name

                # focus on pointer press
                item.pointer.onPress ->
                    if TextInput.keysFocusOnPointerPress
                        @keys.focus = true
                , item

                item

## *Boolean* TextInput.keysFocusOnPointerPress = true

            @keysFocusOnPointerPress = true

            constructor: ->
                super()
                @_text = ''
                @_color = 'black'
                @_lineHeight = 1
                @_multiLine = false
                @_echoMode = 'normal'
                @_alignment = null
                @_font = null
                @_width = 100
                @_height = 50

## *Float* TextInput::width = `100`

## *Float* TextInput::height = `50`

## *String* TextInput::text

## *Signal* TextInput::onTextChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'text'
                defaultValue: ''
                implementation: Impl.setTextInputText
                setter: (_super) -> (val) ->
                    _super.call @, val+''

## *String* TextInput::color = `'black'`

## *Signal* TextInput::onColorChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'color'
                defaultValue: 'black'
                implementation: Impl.setTextInputColor
                implementationValue: do ->
                    RESOURCE_REQUEST =
                        property: 'color'
                    (val) ->
                        Renderer.resources?.resolve(val, RESOURCE_REQUEST) or val
                developmentSetter: (val) ->
                    assert.isString val

## Hidden *Float* TextInput::lineHeight = `1`

## Hidden *Signal* TextInput::onLineHeightChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'lineHeight'
                defaultValue: 1
                implementation: Impl.setTextInputLineHeight
                developmentSetter: (val) ->
                    assert.isFloat val

## *Boolean* TextInput::multiLine = `false`

## *Signal* TextInput::onMultiLineChange(*Boolean* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'multiLine'
                defaultValue: false
                implementation: Impl.setTextInputMultiLine
                developmentSetter: (val) ->
                    assert.isBoolean val

## *String* TextInput::echoMode = `'normal'`

Accepts 'normal' and 'password'.

## *Signal* TextInput::onEchoModeChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'echoMode'
                defaultValue: 'normal'
                implementation: Impl.setTextInputEchoMode
                developmentSetter: (val) ->
                    assert.isString val
                    assert.ok val in ['', 'normal', 'password']
                setter: (_super) -> (val) ->
                    val ||= 'normal'
                    val = val.toLowerCase()
                    _super.call @, val

## Hidden *Item.Alignment* TextInput::alignment

## Hidden *Signal* TextInput::onAlignmentChange(*String* property, *Any* oldValue)

            Renderer.Item.createAlignment TextInput

## *Item.Text.Font* TextInput::font

## *Signal* TextInput::onFontChange(*String* property, *Any* oldValue)

            Renderer.Text.createFont TextInput

        TextInput

# Glossary

- [TextInput](#class-textinput)
