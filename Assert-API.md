> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Assertions**

# Assertions

Access it with:
```javascript
const { assert } = Neft;
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertions)

## Table of contents
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
<dl><dt>Parameters</dt><dd><ul><li><b>expression</b> — <i>Boolean</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertboolean-expression-string-message)

### **Class** assert.AssertionError()

Access it with:
```javascript
const { AssertionError } = Neft.assert;
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#class-assertassertionerror)

###scope
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>message</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>assert</i></dd></dl>
All fail messages will be prefixed by the given *message*.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assert-assertscopestring-message)

###ok
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>expression</b> — <i>Boolean</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertokboolean-expression-string-message)

###notOk
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>expression</b> — <i>Boolean</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotokboolean-expression-string-message)

###is
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>actual</b> — <i>Any</i></li><li><b>expected</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisany-actual-any-expected-string-message)

###isNot
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>actual</b> — <i>Any</i></li><li><b>expected</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotany-actual-any-expected-string-message)

###isDefined
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Checks whether the given value is an undefined or a null.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisdefinedany-value-string-message)

###isNotDefined
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotdefinedany-value-string-message)

###isPrimitive
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isPrimitive()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisprimitiveany-value-string-message)

###isNotPrimitive
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotprimitiveany-value-string-message)

###isString
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>String</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisstringstring-value-string-message)

###isNotString
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotstringany-value-string-message)

###isFloat
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Float</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfloatfloat-value-string-message)

###isNotFloat
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfloatany-value-string-message)

###isInteger
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Integer</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisintegerinteger-value-string-message)

###isNotInteger
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotintegerany-value-string-message)

###isBoolean
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Boolean</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisbooleanboolean-value-string-message)

###isNotBoolean
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotbooleanany-value-string-message)

###isFunction
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Function</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfunctionfunction-value-string-message)

###isNotFunction
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfunctionany-value-string-message)

###isObject
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Object</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisobjectobject-value-string-message)

###isNotObject
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotobjectany-value-string-message)

###isPlainObject
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>PlainObject</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isPlainObject()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisplainobjectplainobject-value-string-message)

###isNotPlainObject
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotplainobjectany-value-string-message)

###isArray
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Array</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisarrayarray-value-string-message)

###isNotArray
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotarrayany-value-string-message)

###isEqual
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value1</b> — <i>Any</i></li><li><b>value2</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd></dl>
Check *utils.isEqual()* for more details.
The given options object accepts: [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) maxDeep.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisequalany-value1-any-value2-string-message-object-options)

###isNotEqual
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value1</b> — <i>Any</i></li><li><b>value2</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li><li><b>options</b> — <i>Object</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotequalany-value1-any-value2-string-message-object-options)

###instanceOf
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>Object</i></li><li><b>constructor</b> — <i>Function</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertinstanceofobject-object-function-constructor-string-message)

###notInstanceOf
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>object</b> — <i>Any</i></li><li><b>constructor</b> — <i>Function</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotinstanceofany-object-function-constructor-string-message)

###lengthOf
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>length</b> — <i>Integer</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertlengthofany-value-integer-length-string-message)

###notLengthOf
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>length</b> — <i>Integer</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotlengthofany-value-integer-length-string-message)

###operator
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value1</b> — <i>Any</i></li><li><b>operator</b> — <i>String</i></li><li><b>value2</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Used to compare the two given values.
```javascript
assert.operator(2, '>', 1);
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertoperatorany-value1-string-operator-any-value2-string-message)

###match
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>regexp</b> — <i>RegExp</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
Used to check whether the given value tests the given regexp.
```javascript
assert.match('12', /[0-9]+/);
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertmatchany-value-regexp-regexp-string-message)

###notMatch
<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>regexp</b> — <i>RegExp</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotmatchany-value-regexp-regexp-string-message)

