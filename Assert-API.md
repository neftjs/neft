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
<dl><dt>Syntax</dt><dd>assert(*Boolean* expression, [*String* message])</dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertboolean-expression-string-message)

### **Class** assert.AssertionError()

Access it with:
```javascript
const { AssertionError } = Neft.assert;
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#class-assertassertionerror)

###scope
<dl><dt>Syntax</dt><dd>*assert* assert.scope(*String* message)</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>message — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>assert</i></dd></dl>
All fail messages will be prefixed by the given *message*.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assert-assertscopestring-message)

###ok
<dl><dt>Syntax</dt><dd>assert.ok(*Boolean* expression, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertokboolean-expression-string-message)

###notOk
<dl><dt>Syntax</dt><dd>assert.notOk(*Boolean* expression, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotokboolean-expression-string-message)

###is
<dl><dt>Syntax</dt><dd>assert.is(*Any* actual, *Any* expected, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>actual — <i>Any</i></li><li>expected — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisany-actual-any-expected-string-message)

###isNot
<dl><dt>Syntax</dt><dd>assert.isNot(*Any* actual, *Any* expected, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>actual — <i>Any</i></li><li>expected — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotany-actual-any-expected-string-message)

###isDefined
<dl><dt>Syntax</dt><dd>assert.isDefined(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Checks whether the given value is an undefined or a null.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisdefinedany-value-string-message)

###isNotDefined
<dl><dt>Syntax</dt><dd>assert.isNotDefined(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotdefinedany-value-string-message)

###isPrimitive
<dl><dt>Syntax</dt><dd>assert.isPrimitive(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isPrimitive()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisprimitiveany-value-string-message)

###isNotPrimitive
<dl><dt>Syntax</dt><dd>assert.isNotPrimitive(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotprimitiveany-value-string-message)

###isString
<dl><dt>Syntax</dt><dd>assert.isString(*String* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>String</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisstringstring-value-string-message)

###isNotString
<dl><dt>Syntax</dt><dd>assert.isNotString(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotstringany-value-string-message)

###isFloat
<dl><dt>Syntax</dt><dd>assert.isFloat([*Float*](/Neft-io/neft/wiki/Utils-API.md#boolean-isfloatany-value) value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Float</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfloatfloat-value-string-message)

###isNotFloat
<dl><dt>Syntax</dt><dd>assert.isNotFloat(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfloatany-value-string-message)

###isInteger
<dl><dt>Syntax</dt><dd>assert.isInteger([*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Integer</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisintegerinteger-value-string-message)

###isNotInteger
<dl><dt>Syntax</dt><dd>assert.isNotInteger(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotintegerany-value-string-message)

###isBoolean
<dl><dt>Syntax</dt><dd>assert.isBoolean(*Boolean* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisbooleanboolean-value-string-message)

###isNotBoolean
<dl><dt>Syntax</dt><dd>assert.isNotBoolean(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotbooleanany-value-string-message)

###isFunction
<dl><dt>Syntax</dt><dd>assert.isFunction(*Function* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfunctionfunction-value-string-message)

###isNotFunction
<dl><dt>Syntax</dt><dd>assert.isNotFunction(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfunctionany-value-string-message)

###isObject
<dl><dt>Syntax</dt><dd>assert.isObject([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Object</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisobjectobject-value-string-message)

###isNotObject
<dl><dt>Syntax</dt><dd>assert.isNotObject(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotobjectany-value-string-message)

###isPlainObject
<dl><dt>Syntax</dt><dd>assert.isPlainObject([*PlainObject*](/Neft-io/neft/wiki/Utils-API.md#boolean-isplainobjectany-value) value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>PlainObject</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isPlainObject()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisplainobjectplainobject-value-string-message)

###isNotPlainObject
<dl><dt>Syntax</dt><dd>assert.isNotPlainObject(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotplainobjectany-value-string-message)

###isArray
<dl><dt>Syntax</dt><dd>assert.isArray(*Array* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Array</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisarrayarray-value-string-message)

###isNotArray
<dl><dt>Syntax</dt><dd>assert.isNotArray(*Any* value, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotarrayany-value-string-message)

###isEqual
<dl><dt>Syntax</dt><dd>assert.isEqual(*Any* value1, *Any* value2, [*String* message, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isEqual()* for more details.
The given options object accepts: [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) maxDeep.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisequalany-value1-any-value2-string-message-object-options)

###isNotEqual
<dl><dt>Syntax</dt><dd>assert.isNotEqual(*Any* value1, *Any* value2, [*String* message, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotequalany-value1-any-value2-string-message-object-options)

###instanceOf
<dl><dt>Syntax</dt><dd>assert.instanceOf([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) object, *Function* constructor, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Object</i></li><li>constructor — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertinstanceofobject-object-function-constructor-string-message)

###notInstanceOf
<dl><dt>Syntax</dt><dd>assert.notInstanceOf(*Any* object, *Function* constructor, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Any</i></li><li>constructor — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotinstanceofany-object-function-constructor-string-message)

###lengthOf
<dl><dt>Syntax</dt><dd>assert.lengthOf(*Any* value, [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) length, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>length — <i>Integer</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertlengthofany-value-integer-length-string-message)

###notLengthOf
<dl><dt>Syntax</dt><dd>assert.notLengthOf(*Any* value, [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) length, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>length — <i>Integer</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotlengthofany-value-integer-length-string-message)

###operator
<dl><dt>Syntax</dt><dd>assert.operator(*Any* value1, *String* operator, *Any* value2, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>operator — <i>String</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Used to compare the two given values.
```javascript
assert.operator(2, '>', 1);
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertoperatorany-value1-string-operator-any-value2-string-message)

###match
<dl><dt>Syntax</dt><dd>assert.match(*Any* value, *RegExp* regexp, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>regexp — <i>RegExp</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Used to check whether the given value tests the given regexp.
```javascript
assert.match('12', /[0-9]+/);
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertmatchany-value-regexp-regexp-string-message)

###notMatch
<dl><dt>Syntax</dt><dd>assert.notMatch(*Any* value, *RegExp* regexp, [*String* message])</dd><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>regexp — <i>RegExp</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotmatchany-value-regexp-regexp-string-message)

