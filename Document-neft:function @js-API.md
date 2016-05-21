> [Wiki](Home) ▸ [API Reference](API-Reference)

neft:function
<dl><dt>Syntax</dt><dd>neft:function @js</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#neftfunction-js)

globalObject
<dl><dt>Syntax</dt><dd>ReadOnly [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) globalObject</dd><dt>Type</dt><dd><i>Object</i></dd><dt>Read only</dt></dl>
Used as a global namespace in the function body.

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#readonly-object-globalobject)

require
<dl><dt>Syntax</dt><dd>*Function* globalObject.require(*String* moduleName)</dd><dt>Static method of</dt><dd><i>globalObject</i></dd><dt>Parameters</dt><dd><ul><li>moduleName — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
Requires standard Neft modules.
```xml
<neft:function neft:name="test">
    var utils = require('utils');
    return utils.arrayToObject([1, 2]);
</neft:function>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#function-globalobjectrequirestring-modulename)

arguments
<dl><dt>Syntax</dt><dd>[*Arguments*](/Neft-io/neft/wiki/Utils-API.md#boolean-isargumentsany-value) globalObject.arguments</dd><dt>Static property of</dt><dd><i>globalObject</i></dd><dt>Type</dt><dd><i>Arguments</i></dd></dl>
Array-like object with arguments passed to the function.
```xml
<neft:function neft:name="followMouse">
    var e = arguments[0]; // Renderer.Item::pointer.onMove comes with event argument
    return [e.x, e.y];
</neft:function>
<button style:pointer:onMove="${funcs.followMouse}" />
```

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#arguments-globalobjectarguments)

