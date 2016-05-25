# Text

```javascript
Text {
    font.pixelSize: 30
    font.family: 'monospace'
    text: '<strong>Neft</strong> Renderer'
    color: 'blue'
}
```

    'use strict'

    assert = require 'src/assert'
    utils = require 'src/utils'
    signal = require 'src/signal'
    log = require 'src/log'

    log = log.scope 'Renderer', 'Text'

# **Class** Text : *Item*

    module.exports = (Renderer, Impl, itemUtils) ->
        class Text extends Renderer.Item
            @__name__ = 'Text'
            @__path__ = 'Renderer.Text'

            @SUPPORTED_HTML_TAGS =
                b: true
                strong: true
                em: true
                br: true
                font: true
                i: true
                s: true
                u: true
                a: true

## *Text* Text.New([*Component* component, *Object* options])

            @New = (component, opts) ->
                item = new Text
                itemUtils.Object.initialize item, component, opts

                # set default font family
                if name = Renderer.FontLoader.getInternalFontName('sans-serif', 0.4, false)
                    Impl.setTextFontFamily.call item, name

                item

            constructor: ->
                super()
                @_text = ''
                @_color = 'black'
                @_linkColor = 'blue'
                @_lineHeight = 1
                @_contentWidth = 0
                @_contentHeight = 0
                @_font = null
                @_alignment = null
                @_autoWidth = true
                @_autoHeight = true
                @_width = -1
                @_height = -1

## *Float* Text::width = `-1`

            _width: -1
            getter = utils.lookupGetter @::, 'width'
            itemWidthSetter = utils.lookupSetter @::, 'width'
            utils.defineProperty @::, 'width', null, getter, do (_super = itemWidthSetter) -> (val) ->
                oldAutoWidth = @_autoWidth
                if @_autoWidth = val is -1
                    _super.call @, @_contentWidth
                else
                    _super.call @, val
                if @_autoWidth or @_autoHeight
                    Impl.updateTextContentSize.call @
                if oldAutoWidth isnt @_autoWidth
                    Impl.setTextWrap.call @, not @_autoWidth
                return

## *Float* Text::height = `-1`

            _height: -1
            getter = utils.lookupGetter @::, 'height'
            itemHeightSetter = utils.lookupSetter @::, 'height'
            utils.defineProperty @::, 'height', null, getter, do (_super = itemHeightSetter) -> (val) ->
                if @_autoHeight = val is -1
                    _super.call @, @_contentHeight
                    Impl.updateTextContentSize.call @
                else
                    _super.call @, val
                return

## *String* Text::text

## *Signal* Text::onTextChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'text'
                defaultValue: ''
                implementation: Impl.setText
                setter: (_super) -> (val) ->
                    _super.call @, val+''

## *String* Text::color = `'black'`

## *Signal* Text::onColorChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'color'
                defaultValue: 'black'
                implementation: Impl.setTextColor
                implementationValue: do ->
                    RESOURCE_REQUEST =
                        property: 'color'
                    (val) ->
                        Renderer.resources?.resolve(val, RESOURCE_REQUEST) or val
                developmentSetter: (val) ->
                    assert.isString val

## *String* Text::linkColor = `'blue'`

## *Signal* Text::onLinkColorChange(*String* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'linkColor'
                defaultValue: 'blue'
                implementation: Impl.setTextLinkColor
                implementationValue: do ->
                    RESOURCE_REQUEST =
                        property: 'color'
                    (val) ->
                        Renderer.resources?.resolve(val, RESOURCE_REQUEST) or val
                developmentSetter: (val) ->
                    assert.isString val

## Hidden *Float* Text::lineHeight = `1`

## Hidden *Signal* Text::onLineHeightChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'lineHeight'
                defaultValue: 1
                implementation: Impl.setTextLineHeight
                developmentSetter: (val) ->
                    assert.isFloat val

## ReadOnly *Float* Text::contentWidth

## *Signal* Text::onContentWidthChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'contentWidth'
                defaultValue: 0
                developmentSetter: (val) ->
                    assert.isFloat val
                setter: (_super) -> (val) ->
                    _super.call @, val
                    if @_autoWidth
                        itemWidthSetter.call @, val
                    return

## ReadOnly *Float* Text::contentHeight

## *Signal* Text::onContentHeightChange(*Float* oldValue)

            itemUtils.defineProperty
                constructor: @
                name: 'contentHeight'
                defaultValue: 0
                developmentSetter: (val) ->
                    assert.isFloat val
                setter: (_super) -> (val) ->
                    _super.call @, val
                    if @_autoHeight
                        itemHeightSetter.call @, val
                    return

## *Item.Alignment* Text::alignment

## *Signal* Text::onAlignmentChange(*String* property, *Any* oldValue)

            Renderer.Item.createAlignment Text

## *Item.Text.Font* Text::font

## *Signal* Text::onFontChange(*String* property, *Any* oldValue)

            @createFont = require('./text/font') Renderer, Impl, itemUtils
            @createFont Text

        Text

# Glossary

- [Text](#class-text)
