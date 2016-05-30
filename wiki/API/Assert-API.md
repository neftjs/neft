> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ **Assertions**

# Assertions

Access it with:
```javascript
const { assert } = Neft;
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#assertions)

## Table of contents
* [Assertions](#assertions)
* [assert](#assert)
  * [**Class** assert.AssertionError](#class-assertassertionerror)
  * [scope](#scope)
  * [ok](#ok)
  * [notOk](#notok)
  * [is](#is)
  * [isNot](#isnot)
  * [isDefined](#isdefined)
  * [isNotDefined](#isnotdefined)
  * [isPrimitive](#isprimitive)
  * [isNotPrimitive](#isnotprimitive)
  * [isString](#isstring)
  * [isNotString](#isnotstring)
  * [isFloat](#isfloat)
  * [isNotFloat](#isnotfloat)
  * [isInteger](#isinteger)
  * [isNotInteger](#isnotinteger)
  * [isBoolean](#isboolean)
  * [isNotBoolean](#isnotboolean)
  * [isFunction](#isfunction)
  * [isNotFunction](#isnotfunction)
  * [isObject](#isobject)
  * [isNotObject](#isnotobject)
  * [isPlainObject](#isplainobject)
  * [isNotPlainObject](#isnotplainobject)
  * [isArray](#isarray)
  * [isNotArray](#isnotarray)
  * [isEqual](#isequal)
  * [isNotEqual](#isnotequal)
  * [instanceOf](#instanceof)
  * [notInstanceOf](#notinstanceof)
  * [lengthOf](#lengthof)
  * [notLengthOf](#notlengthof)
  * [operator](#operator)
  * [match](#match)
  * [notMatch](#notmatch)
* [Glossary](#glossary)

#assert
<dl><dt>Syntax</dt><dd><code>assert(&#x2A;Boolean&#x2A; expression, [&#x2A;String&#x2A; message])</code></dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#assert)

##*[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* assert.AssertionError
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; assert.AssertionError()</code></dd></dl>
Access it with:
```javascript
const { AssertionError } = Neft.assert;
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#class-assertassertionerror)

##scope
<dl><dt>Syntax</dt><dd><code>&#x2A;assert&#x2A; assert.scope(&#x2A;String&#x2A; message)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>message — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd></dl>
All fail messages will be prefixed by the given *message*.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#scope)

##ok
<dl><dt>Syntax</dt><dd><code>assert.ok(&#x2A;Boolean&#x2A; expression, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#ok)

##notOk
<dl><dt>Syntax</dt><dd><code>assert.notOk(&#x2A;Boolean&#x2A; expression, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#notok)

##is
<dl><dt>Syntax</dt><dd><code>assert.is(&#x2A;Any&#x2A; actual, &#x2A;Any&#x2A; expected, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>actual — <i>Any</i></li><li>expected — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#is)

##isNot
<dl><dt>Syntax</dt><dd><code>assert.isNot(&#x2A;Any&#x2A; actual, &#x2A;Any&#x2A; expected, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>actual — <i>Any</i></li><li>expected — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnot)

##isDefined
<dl><dt>Syntax</dt><dd><code>assert.isDefined(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Checks whether the given value is an undefined or a null.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isdefined)

##isNotDefined
<dl><dt>Syntax</dt><dd><code>assert.isNotDefined(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotdefined)

##isPrimitive
<dl><dt>Syntax</dt><dd><code>assert.isPrimitive(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isPrimitive()* for more details.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isprimitive)

##isNotPrimitive
<dl><dt>Syntax</dt><dd><code>assert.isNotPrimitive(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotprimitive)

##isString
<dl><dt>Syntax</dt><dd><code>assert.isString(&#x2A;String&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>String</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isstring)

##isNotString
<dl><dt>Syntax</dt><dd><code>assert.isNotString(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotstring)

##isFloat
<dl><dt>Syntax</dt><dd><code>assert.isFloat(&#x2A;Float&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isfloat)

##isNotFloat
<dl><dt>Syntax</dt><dd><code>assert.isNotFloat(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotfloat)

##isInteger
<dl><dt>Syntax</dt><dd><code>assert.isInteger(&#x2A;Integer&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isinteger)

##isNotInteger
<dl><dt>Syntax</dt><dd><code>assert.isNotInteger(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotinteger)

##isBoolean
<dl><dt>Syntax</dt><dd><code>assert.isBoolean(&#x2A;Boolean&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isboolean)

##isNotBoolean
<dl><dt>Syntax</dt><dd><code>assert.isNotBoolean(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotboolean)

##isFunction
<dl><dt>Syntax</dt><dd><code>assert.isFunction(&#x2A;Function&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isfunction)

##isNotFunction
<dl><dt>Syntax</dt><dd><code>assert.isNotFunction(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotfunction)

##isObject
<dl><dt>Syntax</dt><dd><code>assert.isObject(&#x2A;Object&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isobject)

##isNotObject
<dl><dt>Syntax</dt><dd><code>assert.isNotObject(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotobject)

##isPlainObject
<dl><dt>Syntax</dt><dd><code>assert.isPlainObject(&#x2A;PlainObject&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <a href="/Neft-io/neft/wiki/Utils-API#isplainobject">PlainObject</a></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isPlainObject()* for more details.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isplainobject)

##isNotPlainObject
<dl><dt>Syntax</dt><dd><code>assert.isNotPlainObject(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotplainobject)

##isArray
<dl><dt>Syntax</dt><dd><code>assert.isArray(&#x2A;Array&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Array</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isarray)

##isNotArray
<dl><dt>Syntax</dt><dd><code>assert.isNotArray(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotarray)

##isEqual
<dl><dt>Syntax</dt><dd><code>assert.isEqual(&#x2A;Any&#x2A; value1, &#x2A;Any&#x2A; value2, [&#x2A;String&#x2A; message, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd></dl>
Check *utils.isEqual()* for more details.

The given options object accepts: [Integer](/Neft-io/neft/wiki/Utils-API#isinteger) maxDeep.

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isequal)

##isNotEqual
<dl><dt>Syntax</dt><dd><code>assert.isNotEqual(&#x2A;Any&#x2A; value1, &#x2A;Any&#x2A; value2, [&#x2A;String&#x2A; message, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#isnotequal)

##instanceOf
<dl><dt>Syntax</dt><dd><code>assert.instanceOf(&#x2A;Object&#x2A; object, &#x2A;Function&#x2A; constructor, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>object — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li><li>constructor — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#instanceof)

##notInstanceOf
<dl><dt>Syntax</dt><dd><code>assert.notInstanceOf(&#x2A;Any&#x2A; object, &#x2A;Function&#x2A; constructor, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>object — <i>Any</i></li><li>constructor — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#notinstanceof)

##lengthOf
<dl><dt>Syntax</dt><dd><code>assert.lengthOf(&#x2A;Any&#x2A; value, &#x2A;Integer&#x2A; length, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>length — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#lengthof)

##notLengthOf
<dl><dt>Syntax</dt><dd><code>assert.notLengthOf(&#x2A;Any&#x2A; value, &#x2A;Integer&#x2A; length, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>length — <a href="/Neft-io/neft/wiki/Utils-API#isinteger">Integer</a></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#notlengthof)

##operator
<dl><dt>Syntax</dt><dd><code>assert.operator(&#x2A;Any&#x2A; value1, &#x2A;String&#x2A; operator, &#x2A;Any&#x2A; value2, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>operator — <i>String</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Used to compare the two given values.

```javascript
assert.operator(2, '>', 1);
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#operator)

##match
<dl><dt>Syntax</dt><dd><code>assert.match(&#x2A;Any&#x2A; value, &#x2A;RegExp&#x2A; regexp, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>regexp — <i>RegExp</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Used to check whether the given value tests the given regexp.

```javascript
assert.match('12', /[0-9]+/);
```

> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#match)

##notMatch
<dl><dt>Syntax</dt><dd><code>assert.notMatch(&#x2A;Any&#x2A; value, &#x2A;RegExp&#x2A; regexp, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Assert-API#assert">assert</a></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>regexp — <i>RegExp</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/e79ebc2b61607e795a53c22d1577605addf00689/src/assert/index.litcoffee#notmatch)

# Glossary

- [assert](#assert)

