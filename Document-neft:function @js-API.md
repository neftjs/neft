> [Wiki](Home) ▸ [API Reference](API-Reference)

neft:function
> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#neftfunction-js)

globalObject
Used as a global namespace in the function body.

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#readonly-object-globalobject)

require
Requires standard Neft modules.
```xml
<neft:function neft:name="test">
    var utils = require('utils');
    return utils.arrayToObject([1, 2]);
</neft:function>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#function-globalobjectrequirestring-modulename)

arguments
Array-like object with arguments passed to the function.
```xml
<neft:function neft:name="followMouse">
    var e = arguments[0]; // Renderer.Item::pointer.onMove comes with event argument
    return [e.x, e.y];
</neft:function>
<button style:pointer:onMove="${funcs.followMouse}" />
```

> [`Source`](/Neft-io/neft/tree/master/src/document/func.litcoffee#arguments-globalobjectarguments)

