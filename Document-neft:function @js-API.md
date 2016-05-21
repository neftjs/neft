> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]]

neft:function
<dl><dt>Syntax</dt><dd><code>neft:function @js</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/func.litcoffee#neftfunction)

globalObject
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Object&#x2A; globalObject</code></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd><dt>Read Only</dt></dl>
Used as a global namespace in the function body.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/func.litcoffee#globalobject)

require
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; globalObject.require(&#x2A;String&#x2A; moduleName)</code></dd><dt>Static method of</dt><dd><i>globalObject</i></dd><dt>Parameters</dt><dd><ul><li>moduleName — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>Function</i></dd></dl>
Requires standard Neft modules.

```xml
<neft:function neft:name="test">
    var utils = require('utils');
    return utils.arrayToObject([1, 2]);
</neft:function>
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/func.litcoffee#require)

arguments
<dl><dt>Syntax</dt><dd><code>&#x2A;Arguments&#x2A; globalObject.arguments</code></dd><dt>Static property of</dt><dd><i>globalObject</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isarguments">Arguments</a></dd></dl>
Array-like object with arguments passed to the function.

```xml
<neft:function neft:name="followMouse">
    var e = arguments[0]; // Renderer.Item::pointer.onMove comes with event argument
    return [e.x, e.y];
</neft:function>

<button style:pointer:onMove="${funcs.followMouse}" />
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/func.litcoffee#arguments)

