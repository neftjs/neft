Grid @class
===========

```nml
`Grid {
`   spacing.column: 15
`   spacing.row: 5
`   columns: 2
`
`   Rectangle { color: 'blue'; width: 60; height: 50; }
`   Rectangle { color: 'green'; width: 20; height: 70; }
`   Rectangle { color: 'red'; width: 50; height: 30; }
`   Rectangle { color: 'yellow'; width: 20; height: 20; }
`}
```

*Grid* Grid.New([*Component* component, *Object* options])
----------------------------------------------------------

*Grid* Grid() : *Renderer.Item*
-------------------------------

*Margin* Grid::padding
----------------------

## *Signal* Grid::onPaddingChange(*Margin* padding)

*Integer* Grid::columns = 2
---------------------------

## *Signal* Grid::onColumnsChange(*Integer* oldValue)

*Integer* Grid::rows = Infinity
-------------------------------

## *Signal* Grid::onRowsChange(*Integer* oldValue)

*Spacing* Grid::spacing
-----------------------

## *Signal* Grid::onSpacingChange(*Spacing* oldValue)

*Alignment* Grid::alignment
---------------------------

## *Signal* Grid::onAlignmentChange(*Alignment* oldValue)

*Boolean* Grid::includeBorderMargins = false
--------------------------------------------

## *Signal* Grid::onIncludeBorderMarginsChange(*Boolean* oldValue)

