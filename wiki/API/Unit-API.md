> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Unit tests**

# Unit tests

Access it with:
```javascript
const unit = require('src/unit');
```

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/unit/index.litcoffee#unit-tests)

## Nested APIs

* [[isNode|Unit-isNode-API]]

## Table of contents
* [Unit tests](#unit-tests)
* [describe](#describe)
* [it](#it)
* [beforeEach](#beforeeach)
* [afterEach](#aftereach)
* [whenChange](#whenchange)
* [runTests](#runtests)
* [onTestsEnd](#ontestsend)
* [runAutomatically](#runautomatically)

#describe
<dl><dt>Syntax</dt><dd><code>unit.describe(&#x2A;String&#x2A; message, &#x2A;Function&#x2A; tests)</code></dd><dt>Static method of</dt><dd><i>unit</i></dd><dt>Parameters</dt><dd><ul><li>message — <i>String</i></li><li>tests — <i>Function</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/unit/index.litcoffee#describe)

#it
<dl><dt>Syntax</dt><dd><code>unit.it(&#x2A;String&#x2A; message, &#x2A;Function&#x2A; test)</code></dd><dt>Static method of</dt><dd><i>unit</i></dd><dt>Parameters</dt><dd><ul><li>message — <i>String</i></li><li>test — <i>Function</i></li></ul></dd></dl>
The given test function can contains optional *callback* argument.

> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/unit/index.litcoffee#it)

#beforeEach
<dl><dt>Syntax</dt><dd><code>unit.beforeEach(&#x2A;Function&#x2A; code)</code></dd><dt>Static method of</dt><dd><i>unit</i></dd><dt>Parameters</dt><dd><ul><li>code — <i>Function</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/unit/index.litcoffee#beforeeach)

#afterEach
<dl><dt>Syntax</dt><dd><code>unit.afterEach(&#x2A;Function&#x2A; code)</code></dd><dt>Static method of</dt><dd><i>unit</i></dd><dt>Parameters</dt><dd><ul><li>code — <i>Function</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/unit/index.litcoffee#aftereach)

#whenChange
<dl><dt>Syntax</dt><dd><code>unit.whenChange(&#x2A;Object&#x2A; watchObject, &#x2A;Function&#x2A; callback, [&#x2A;Integer&#x2A; maxDelay = `1000`])</code></dd><dt>Static method of</dt><dd><i>unit</i></dd><dt>Parameters</dt><dd><ul><li>watchObject — <a href="/Neft-io/neft/Utils-API.md#isobject">Object</a></li><li>callback — <i>Function</i></li><li>maxDelay — <a href="/Neft-io/neft/Utils-API.md#isinteger">Integer</a> — <code>= 1000</code> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/unit/index.litcoffee#whenchange)

#runTests
<dl><dt>Syntax</dt><dd><code>unit.runTests()</code></dd><dt>Static method of</dt><dd><i>unit</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/unit/index.litcoffee#runtests)

#onTestsEnd
<dl><dt>Syntax</dt><dd><code>&#x2A;Function&#x2A; unit.onTestsEnd</code></dd><dt>Static property of</dt><dd><i>unit</i></dd><dt>Type</dt><dd><i>Function</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/unit/index.litcoffee#ontestsend)

#runAutomatically
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; unit.runAutomatically = true</code></dd><dt>Static property of</dt><dd><i>unit</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>true</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/65f8de73ffc0dbb38be0f58144f629599500b1a9/src/unit/index.litcoffee#runautomatically)

