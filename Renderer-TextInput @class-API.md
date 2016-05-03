TextInput @class
================

*TextInput* TextInput.New([*Component* component, *Object* options])
--------------------------------------------------------------------

*Boolean* TextInput.keysFocusOnPointerPress = true
--------------------------------------------------

*TextInput* TextInput() : *Renderer.Item*
-----------------------------------------

*Float* TextInput::width = 100
------------------------------

*Float* TextInput::height = 50
------------------------------

*String* TextInput::text
------------------------

## *Signal* TextInput::onTextChange(*String* oldValue)

*String* TextInput::color = 'black'
-----------------------------------

## *Signal* TextInput::onColorChange(*String* oldValue)

Hidden *Float* TextInput::lineHeight = 1
----------------------------------------

## Hidden *Signal* TextInput::onLineHeightChange(*Float* oldValue)

*Boolean* TextInput::multiLine = false
--------------------------------------

## *Signal* TextInput::onMultiLineChange(*Boolean* oldValue)

*String* TextInput::echoMode = 'normal'
---------------------------------------

Accepts 'normal' and 'password'.

## *Signal* TextInput::onEchoModeChange(*String* oldValue)

Hidden *Alignment* TextInput::alignment
---------------------------------------

## Hidden *Signal* TextInput::onAlignmentChange(*Alignment* alignment)

*Font* TextInput::font
----------------------

## *Signal* TextInput::onFontChange(*String* property, *Any* oldValue)

