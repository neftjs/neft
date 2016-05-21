> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
neft:function
> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#neftfunction-js)

<dl><dt>Type</dt><dd><i>Object</i></dd><dt>read only</dt></dl>
globalObject
Used as a global namespace in the function body.

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#readonly-object-globalobject)

<dl><dt>Static method of</dt><dd><i>globalObject</i></dd><dt>Parameters</dt><dd><ul><li><b>moduleName</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
require
Requires standard Neft modules.
```xml
<neft:function neft:name="test">
    var utils = require('utils');
    return utils.arrayToObject([1, 2]);
</neft:function>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#function-globalobjectrequirestring-modulename)

## Table of contents
    * [neft:function](#neftfunction)
    * [globalObject](#globalobject)
    * [require](#require)
  * [*Arguments* globalObject.arguments](#arguments-globalobjectarguments)

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

