> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Assertions**

# Assertions

Access it with:
```javascript
const { assert } = Neft;
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertions)

## Table of contents
* [Assertions](#assertions)
  * [assert](#assert)
    * [**Class** assert.AssertionError()](#class-assertassertionerror)
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

##assert
<dl><dt>Syntax</dt><dd><code>assert(&#x2A;Boolean&#x2A; expression, [&#x2A;String&#x2A; message])</code></dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertboolean-expression-string-message)

### **Class** assert.AssertionError()

Access it with:
```javascript
const { AssertionError } = Neft.assert;
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#class-assertassertionerror)

###scope
<dl><dt>Syntax</dt><dd><code>&#x2A;assert&#x2A; assert.scope(&#x2A;String&#x2A; message)</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>message — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>assert</i></dd></dl>
All fail messages will be prefixed by the given *message*.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assert-assertscopestring-message)

###ok
<dl><dt>Syntax</dt><dd><code>assert.ok(&#x2A;Boolean&#x2A; expression, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertokboolean-expression-string-message)

###notOk
<dl><dt>Syntax</dt><dd><code>assert.notOk(&#x2A;Boolean&#x2A; expression, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotokboolean-expression-string-message)

###is
<dl><dt>Syntax</dt><dd><code>assert.is(&#x2A;Any&#x2A; actual, &#x2A;Any&#x2A; expected, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>actual — <i>Any</i></li><li>expected — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisany-actual-any-expected-string-message)

###isNot
<dl><dt>Syntax</dt><dd><code>assert.isNot(&#x2A;Any&#x2A; actual, &#x2A;Any&#x2A; expected, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>actual — <i>Any</i></li><li>expected — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotany-actual-any-expected-string-message)

###isDefined
<dl><dt>Syntax</dt><dd><code>assert.isDefined(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Checks whether the given value is an undefined or a null.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisdefinedany-value-string-message)

###isNotDefined
<dl><dt>Syntax</dt><dd><code>assert.isNotDefined(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotdefinedany-value-string-message)

###isPrimitive
<dl><dt>Syntax</dt><dd><code>assert.isPrimitive(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isPrimitive()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisprimitiveany-value-string-message)

###isNotPrimitive
<dl><dt>Syntax</dt><dd><code>assert.isNotPrimitive(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotprimitiveany-value-string-message)

###isString
<dl><dt>Syntax</dt><dd><code>assert.isString(&#x2A;String&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>String</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisstringstring-value-string-message)

###isNotString
<dl><dt>Syntax</dt><dd><code>assert.isNotString(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotstringany-value-string-message)

###isFloat
<dl><dt>Syntax</dt><dd><code>assert.isFloat(&#x2A;Float&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Float</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfloatfloat-value-string-message)

###isNotFloat
<dl><dt>Syntax</dt><dd><code>assert.isNotFloat(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfloatany-value-string-message)

###isInteger
<dl><dt>Syntax</dt><dd><code>assert.isInteger(&#x2A;Integer&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Integer</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisintegerinteger-value-string-message)

###isNotInteger
<dl><dt>Syntax</dt><dd><code>assert.isNotInteger(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotintegerany-value-string-message)

###isBoolean
<dl><dt>Syntax</dt><dd><code>assert.isBoolean(&#x2A;Boolean&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisbooleanboolean-value-string-message)

###isNotBoolean
<dl><dt>Syntax</dt><dd><code>assert.isNotBoolean(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotbooleanany-value-string-message)

###isFunction
<dl><dt>Syntax</dt><dd><code>assert.isFunction(&#x2A;Function&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfunctionfunction-value-string-message)

###isNotFunction
<dl><dt>Syntax</dt><dd><code>assert.isNotFunction(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfunctionany-value-string-message)

###isObject
<dl><dt>Syntax</dt><dd><code>assert.isObject(&#x2A;Object&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Object</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisobjectobject-value-string-message)

###isNotObject
<dl><dt>Syntax</dt><dd><code>assert.isNotObject(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotobjectany-value-string-message)

###isPlainObject
<dl><dt>Syntax</dt><dd><code>assert.isPlainObject(&#x2A;PlainObject&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>PlainObject</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isPlainObject()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisplainobjectplainobject-value-string-message)

###isNotPlainObject
<dl><dt>Syntax</dt><dd><code>assert.isNotPlainObject(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotplainobjectany-value-string-message)

###isArray
<dl><dt>Syntax</dt><dd><code>assert.isArray(&#x2A;Array&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Array</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisarrayarray-value-string-message)

###isNotArray
<dl><dt>Syntax</dt><dd><code>assert.isNotArray(&#x2A;Any&#x2A; value, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotarrayany-value-string-message)

###isEqual
<dl><dt>Syntax</dt><dd><code>assert.isEqual(&#x2A;Any&#x2A; value1, &#x2A;Any&#x2A; value2, [&#x2A;String&#x2A; message, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isEqual()* for more details.
The given options object accepts: [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) maxDeep.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisequalany-value1-any-value2-string-message-object-options)

###isNotEqual
<dl><dt>Syntax</dt><dd><code>assert.isNotEqual(&#x2A;Any&#x2A; value1, &#x2A;Any&#x2A; value2, [&#x2A;String&#x2A; message, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotequalany-value1-any-value2-string-message-object-options)

###instanceOf
<dl><dt>Syntax</dt><dd><code>assert.instanceOf(&#x2A;Object&#x2A; object, &#x2A;Function&#x2A; constructor, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Object</i></li><li>constructor — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertinstanceofobject-object-function-constructor-string-message)

###notInstanceOf
<dl><dt>Syntax</dt><dd><code>assert.notInstanceOf(&#x2A;Any&#x2A; object, &#x2A;Function&#x2A; constructor, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Any</i></li><li>constructor — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotinstanceofany-object-function-constructor-string-message)

###lengthOf
<dl><dt>Syntax</dt><dd><code>assert.lengthOf(&#x2A;Any&#x2A; value, &#x2A;Integer&#x2A; length, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>length — <i>Integer</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertlengthofany-value-integer-length-string-message)

###notLengthOf
<dl><dt>Syntax</dt><dd><code>assert.notLengthOf(&#x2A;Any&#x2A; value, &#x2A;Integer&#x2A; length, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>length — <i>Integer</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotlengthofany-value-integer-length-string-message)

###operator
<dl><dt>Syntax</dt><dd><code>assert.operator(&#x2A;Any&#x2A; value1, &#x2A;String&#x2A; operator, &#x2A;Any&#x2A; value2, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>operator — <i>String</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Used to compare the two given values.
```javascript
assert.operator(2, '>', 1);
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertoperatorany-value1-string-operator-any-value2-string-message)

###match
<dl><dt>Syntax</dt><dd><code>assert.match(&#x2A;Any&#x2A; value, &#x2A;RegExp&#x2A; regexp, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>regexp — <i>RegExp</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Used to check whether the given value tests the given regexp.
```javascript
assert.match('12', /[0-9]+/);
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertmatchany-value-regexp-regexp-string-message)

###notMatch
<dl><dt>Syntax</dt><dd><code>assert.notMatch(&#x2A;Any&#x2A; value, &#x2A;RegExp&#x2A; regexp, [&#x2A;String&#x2A; message])</code></dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>regexp — <i>RegExp</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotmatchany-value-regexp-regexp-string-message)

