> [Wiki](Home) ▸ [API Reference](API-Reference)

Unit
<dl><dt>Syntax</dt><dd><code>Unit @library</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/unit/index.litcoffee#unit-library)

describe
<dl><dt>Syntax</dt><dd><code>Unit.describe(&#x2A;String&#x2A; message, &#x2A;Function&#x2A; tests)</code></dd><dt>Static method of</dt><dd><i>Unit</i></dd><dt>Parameters</dt><dd><ul><li>message — <i>String</i></li><li>tests — <i>Function</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/unit/index.litcoffee#unitdescribestring-message-function-tests)

it
<dl><dt>Syntax</dt><dd><code>Unit.it(&#x2A;String&#x2A; message, &#x2A;Function&#x2A; test)</code></dd><dt>Static method of</dt><dd><i>Unit</i></dd><dt>Parameters</dt><dd><ul><li>message — <i>String</i></li><li>test — <i>Function</i></li></ul></dd></dl>
The given test function can contains optional *callback* argument.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/unit/index.litcoffee#unititstring-message-function-test)

beforeEach
<dl><dt>Syntax</dt><dd><code>Unit.beforeEach(&#x2A;Function&#x2A; code)</code></dd><dt>Static method of</dt><dd><i>Unit</i></dd><dt>Parameters</dt><dd><ul><li>code — <i>Function</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/unit/index.litcoffee#unitbeforeeachfunction-code)

afterEach
<dl><dt>Syntax</dt><dd><code>Unit.afterEach(&#x2A;Function&#x2A; code)</code></dd><dt>Static method of</dt><dd><i>Unit</i></dd><dt>Parameters</dt><dd><ul><li>code — <i>Function</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/unit/index.litcoffee#unitaftereachfunction-code)

whenChange
<dl><dt>Syntax</dt><dd><code>Unit.whenChange(&#x2A;Object&#x2A; watchObject, &#x2A;Function&#x2A; callback, [&#x2A;Integer&#x2A; maxDelay = `1000`])</code></dd><dt>Static method of</dt><dd><i>Unit</i></dd><dt>Parameters</dt><dd><ul><li>watchObject — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value">Object</a></li><li>callback — <i>Function</i></li><li>maxDelay — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value">Integer</a> — <code>= 1000</code> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/unit/index.litcoffee#unitwhenchangeobject-watchobject-function-callback-integer-maxdelay--1000)

runTests
<dl><dt>Syntax</dt><dd><code>Unit.runTests()</code></dd><dt>Static method of</dt><dd><i>Unit</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/unit/index.litcoffee#unitruntests)

onTestsEnd
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; Unit.onTestsEnd</code></dd><dt>Static property of</dt><dd><i>Unit</i></dd><dt>Type</dt><dd><i>Function</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/unit/index.litcoffee#function-unitontestsend)

runAutomatically
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Unit.runAutomatically = true</code></dd><dt>Static property of</dt><dd><i>Unit</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/unit/index.litcoffee#boolean-unitrunautomatically--true)

