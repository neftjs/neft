Text @class
===========

```nml
`Text {
`   font.pixelSize: 30
`   font.family: 'monospace'
`   text: '<strong>Neft</strong> Renderer'
`   color: 'blue'
`}
```

*Text* Text.New([*Component* component, *Object* options])
----------------------------------------------------------

*Text* Text() : *Renderer.Item*
-------------------------------

*Float* Text::width = -1
------------------------

*Float* Text::height = -1
-------------------------

*String* Text::text
-------------------

## *Signal* Text::onTextChange(*String* oldValue)

*String* Text::color = 'black'
------------------------------

## *Signal* Text::onColorChange(*String* oldValue)

*String* Text::linkColor = 'blue'
---------------------------------

## *Signal* Text::onLinkColorChange(*String* oldValue)

Hidden *Float* Text::lineHeight = 1
-----------------------------------

## Hidden *Signal* Text::onLineHeightChange(*Float* oldValue)

ReadOnly *Float* Text::contentWidth
-----------------------------------

## *Signal* Text::onContentWidthChange(*Float* oldValue)

ReadOnly *Float* Text::contentHeight
------------------------------------

## *Signal* Text::onContentHeightChange(*Float* oldValue)

*Alignment* Text::alignment
---------------------------

## *Signal* Text::onAlignmentChange(*Alignment* alignment)

*Font* Text::font
-----------------

## *Signal* Text::onFontChange(*String* property, *Any* oldValue)

