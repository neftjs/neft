> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **neft:function @js**

neft:function @js
=================

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#neftfunction-js)

## Table of contents
  * [globalObject](#readonly-object-globalobject)
  * [globalObject.require(moduleName)](#function-globalobjectrequirestring-modulename)
  * [globalObject.arguments](#arguments-globalobjectarguments)

ReadOnly [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) globalObject
------------------------------

Used as a global namespace in the function body.

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#readonly-object-globalobject)

*Function* globalObject.require(*String* moduleName)
----------------------------------------------------

Requires standard Neft modules.
```xml
<neft:function neft:name="test">
    var utils = require('utils');
    return utils.arrayToObject([1, 2]);
</neft:function>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#function-globalobjectrequirestring-modulename)

[*Arguments*](/Neft-io/neft/wiki/Utils-API.md#boolean-isargumentsany-value) globalObject.arguments
----------------------------------

Array-like object with arguments passed to the function.
```xml
<neft:function neft:name="followMouse">
    var e = arguments[0]; // Renderer.Item::pointer.onMove comes with event argument
    return [e.x, e.y];
</neft:function>
<button style:pointer:onMove="${funcs.followMouse}" />
```

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#arguments-globalobjectarguments)

