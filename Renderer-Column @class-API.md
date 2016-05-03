Column @class
=============

```nml
`Column {
`   spacing: 5
`
`   Rectangle { color: 'blue'; width: 50; height: 50; }
`   Rectangle { color: 'green'; width: 20; height: 50; }
`   Rectangle { color: 'red'; width: 50; height: 20; }
`}
```

*Column* Column.New([*Component* component, *Object* options])
--------------------------------------------------------------

*Column* Column() : *Renderer.Item*
-----------------------------------

*Margin* Column::padding
------------------------

## *Signal* Column::onPaddingChange(*Margin* padding)

*Float* Column::spacing = 0
---------------------------

## *Signal* Column::onSpacingChange(*Float* oldValue)

*Alignment* Column::alignment
-----------------------------

## *Signal* Column::onAlignmentChange(*Alignment* oldValue)

*Boolean* Column::includeBorderMargins = false
----------------------------------------------

## *Signal* Column::onIncludeBorderMarginsChange(*Boolean* oldValue)

