Class @modifier
===============

*Class* Class.New([*Component* component, *Object* options])
------------------------------------------------------------

*Class* Class()
---------------

*String* Class::name
--------------------

This property is used in the [Item::classes][renderer/Item::classes] list
to identify various classes.

## *Signal* Class::onNameChange(*String* oldValue)

*Renderer.Item* Class::target
-----------------------------

Reference to the [Item][renderer/Item] on which this class has effects.

If state is created inside the [Item][renderer/Item], this property is set automatically.

## *Signal* Class::onTargetChange(*Renderer.Item* oldValue)

*Object* Class::changes
-----------------------

This objects contains all properties to change on the target item.

It accepts bindings and listeners as well.

*Integer* Class::priority = 0
-----------------------------

## *Signal* Class::onPriorityChange(*Integer* oldValue)

*Boolean* Class::when
---------------------

Indicates whether the class is active or not.

When it's `true`, this state is appended on the
end of the [Item::classes][renderer/Item::classes] list.

Mostly used with bindings.

```nml
`Grid {
`   columns: 2
`   // reduce to one column if the view width is lower than 500 pixels
`   Class {
`       when: view.width < 500
`       changes: {
`           columns: 1
`       }
`   }
`}
```

## *Signal* Class::onWhenChange(*Boolean* oldValue)

*Object* Class::children
------------------------

*Integer* Class::children.length = 0
------------------------------------

*Object* Class::children.append(*Object* value)
-----------------------------------------------

*Object* Class::children.pop(*Integer* index)
---------------------------------------------

*ClassDocument* Class::document
-------------------------------

## *Signal* Class::onDocumentChange(*ClassDocument* document)

*ClassDocument* ClassDocument()
-------------------------------

*String* ClassDocument::query
-----------------------------

## *Signal* ClassDocument::onQueryChange(*String* oldValue)

*Signal* ClassDocument::onNodeAdd(*Document.Element* node)
----------------------------------------------------------

*Signal* ClassDocument::onNodeRemove(*Document.Element* node)
-------------------------------------------------------------

*List* Item::classes
--------------------

Classs at the end of the list have the highest priority.

This property has a setter, which accepts a string and an array of strings.

## *Signal* Item::onClassesChange(*String* added, *String* removed)

