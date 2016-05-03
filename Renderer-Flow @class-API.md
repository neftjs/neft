Flow @class
===========

```nml
`Flow {
`   width: 90
`   spacing.column: 15
`   spacing.row: 5
`
`   Rectangle { color: 'blue'; width: 60; height: 50; }
`   Rectangle { color: 'green'; width: 20; height: 70; }
`   Rectangle { color: 'red'; width: 50; height: 30; }
`   Rectangle { color: 'yellow'; width: 20; height: 20; }
`}
```

*Flow* Flow.New([*Component* component, *Object* options])
----------------------------------------------------------

*Flow* Flow() : *Renderer.Item*
-------------------------------

*Margin* Flow::padding
----------------------

## *Signal* Flow::onPaddingChange(*Margin* padding)

*Spacing* Flow::spacing
-----------------------

## *Signal* Flow::onSpacingChange(*Spacing* oldValue)

*Alignment* Flow::alignment
---------------------------

## *Signal* Flow::onAlignmentChange(*Alignment* oldValue)

*Boolean* Flow::includeBorderMargins = false
-------------------------------------------

## *Signal* Flow::onIncludeBorderMarginsChange(*Boolean* oldValue)

*Boolean* Flow::collapseMargins = false
---------------------------------------

## *Signal* Flow::onCollapseMarginsChange(*Boolean* oldValue)

