Tag @virtual_dom
================

*Tag* Tag() : *Element*
-----------------------

*String* Tag::name
------------------

*Array* Tag::children
---------------------

## *Signal* Tag::onChildrenChange(*Element* added, *Element* removed)

*Attrs* Tag::attrs
------------------

## *Signal* Tag::onAttrsChange(*String* attribute, *Any* oldValue)

*Tag* Tag::cloneDeep()
----------------------

*Element* Tag::getCopiedElement(*Element* lookForElement, *Element* copiedParent)
---------------------------------------------------------------------------------

*Tag* Tag::getChildByAccessPath(*Array* accessPath)
---------------------------------------------------

*Array* Tag::queryAll(*String* query, [*Function* onElement, *Any* onElementContext])
-------------------------------------------------------------------------------------

*Element* Tag::query(*String* query)
------------------------------------

*Watcher* Tag::watch(*String* query)
------------------------------------

```javascript
var watcher = doc.watch('div > * > b[attr]');
watcher.onAdd(function(tag){});
watcher.onRemove(function(tag){});
watcher.disconnect();
```

*String* Tag::stringify([*Object* replacements])
------------------------------------------------

*String* Tag::stringifyChildren([*Object* replacements])
--------------------------------------------------------

Tag::replace(*Element* oldElement, *Element* newElement)
--------------------------------------------------------

*Attrs* Attrs()
---------------

*Array* Attrs::item(*Integer* index, [*Array* target])
------------------------------------------------------

*Boolean* Attrs::has(*String* name)
-----------------------------------

*Boolean* Attrs::set(*String* name, *Any* value)
------------------------------------------------

