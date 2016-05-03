Row @class
==========

```nml
`Row {
`   spacing: 5
`
`   Rectangle { color: 'blue'; width: 50; height: 50; }
`   Rectangle { color: 'green'; width: 20; height: 50; }
`   Rectangle { color: 'red'; width: 50; height: 20; }
`}
```

*Row* Row.New([*Component* component, *Object* options])
--------------------------------------------------------

*Row* Row() : *Renderer.Item*
-----------------------------

*Margin* Row::padding
---------------------

## *Signal* Row::onPaddingChange(*Margin* padding)

*Float* Row::spacing = 0
------------------------

## *Signal* Row::onSpacingChange(*Float* oldValue)

*Alignment* Row::alignment
--------------------------

## *Signal* Row::onAlignmentChange(*Alignment* oldValue)

*Boolean* Row::includeBorderMargins = false
-------------------------------------------

## *Signal* Row::onIncludeBorderMarginsChange(*Boolean* oldValue)

