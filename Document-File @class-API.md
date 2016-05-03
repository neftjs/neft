File @class
===========

*Signal* File.onBeforeRender(*File* file)
-----------------------------------------

Corresponding node handler: *neft:onBeforeRender=""*.

*Signal* File.onRender(*File* file)
-----------------------------------

Corresponding node handler: *neft:onRender=""*.

*Signal* File.onBeforeRevert(*File* file)
-----------------------------------------

Corresponding node handler: *neft:onBeforeRevert=""*.

*Signal* File.onRevert(*File* file)
-----------------------------------

Corresponding node handler: *neft:onRevert=""*.

*File* File.fromHTML(*String* path, *String* html)
--------------------------------------------------

*File* File.fromElement(*String* path, *Element* element)
---------------------------------------------------------

*File* File.fromJSON(*String|Object* json)
------------------------------------------

File.parse(*File* file)
-----------------------

*File* File.factory(*String* path)
----------------------------------

*File* File(*String* path, *Element* element)
---------------------------------------------

*File* File::render([*Any* attrs, *Any* scope, *File* source])
--------------------------------------------------------------

*File* File::revert()
---------------------

*File* File::use(*String* useName, [*File* document])
-----------------------------------------------------

*Signal* File::onReplaceByUse(*File.Use* use)
---------------------------------------------

Corresponding node handler: *neft:onReplaceByUse=""*.

*File* File::clone()
--------------------

File::destroy()
---------------

*Object* File::toJSON()
-----------------------

