> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Assertions**

# Assertions

Access it with:
```javascript
const { assert } = Neft;
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertions)

<dl><dt>Parameters</dt><dd><ul><li><b>expression</b> — <i>Boolean</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
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
    * [assert.isNotArray(*Any* value, [*String* message])](#assertisnotarrayany-value-string-message)
    * [assert.isEqual(*Any* value1, *Any* value2, [*String* message, *Object* options])](#assertisequalany-value1-any-value2-string-message-object-options)
    * [assert.isNotEqual(*Any* value1, *Any* value2, [*String* message, *Object* options])](#assertisnotequalany-value1-any-value2-string-message-object-options)
    * [assert.instanceOf(*Object* object, *Function* constructor, [*String* message])](#assertinstanceofobject-object-function-constructor-string-message)
    * [assert.notInstanceOf(*Any* object, *Function* constructor, [*String* message])](#assertnotinstanceofany-object-function-constructor-string-message)
    * [assert.lengthOf(*Any* value, *Integer* length, [*String* message])](#assertlengthofany-value-integer-length-string-message)
    * [assert.notLengthOf(*Any* value, *Integer* length, [*String* message])](#assertnotlengthofany-value-integer-length-string-message)
    * [assert.operator(*Any* value1, *String* operator, *Any* value2, [*String* message])](#assertoperatorany-value1-string-operator-any-value2-string-message)
    * [assert.match(*Any* value, *RegExp* regexp, [*String* message])](#assertmatchany-value-regexp-regexp-string-message)
    * [assert.notMatch(*Any* value, *RegExp* regexp, [*String* message])](#assertnotmatchany-value-regexp-regexp-string-message)

##assert
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertboolean-expression-string-message)

### **Class** assert.AssertionError()

Access it with:
```javascript
const { AssertionError } = Neft.assert;
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#class-assertassertionerror)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>message</b> — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>assert</i></dd></dl>
###scope
All fail messages will be prefixed by the given *message*.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assert-assertscopestring-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>expression</b> — <i>Boolean</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###ok
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertokboolean-expression-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>expression</b> — <i>Boolean</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###notOk
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotokboolean-expression-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>actual</b> — <i>Any</i></li><li><b>expected</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###is
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisany-actual-any-expected-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>actual</b> — <i>Any</i></li><li><b>expected</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isNot
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotany-actual-any-expected-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isDefined
Checks whether the given value is an undefined or a null.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisdefinedany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isNotDefined
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotdefinedany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isPrimitive
Check *utils.isPrimitive()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisprimitiveany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isNotPrimitive
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotprimitiveany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>String</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isString
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisstringstring-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isNotString
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotstringany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Float</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isFloat
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfloatfloat-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isNotFloat
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfloatany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Integer</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isInteger
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisintegerinteger-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isNotInteger
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotintegerany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Boolean</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isBoolean
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisbooleanboolean-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isNotBoolean
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotbooleanany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Function</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isFunction
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfunctionfunction-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isNotFunction
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfunctionany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Object</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isObject
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisobjectobject-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isNotObject
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotobjectany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>PlainObject</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isPlainObject
Check *utils.isPlainObject()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisplainobjectplainobject-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Any</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isNotPlainObject
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotplainobjectany-value-string-message)

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li><b>value</b> — <i>Array</i></li><li><b>message</b> — <i>String</i> — <i>optional</i></li></ul></dd></dl>
###isArray
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisarrayarray-value-string-message)

### assert.isNotArray(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotarrayany-value-string-message)

### assert.isEqual(*Any* value1, *Any* value2, [*String* message, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])

Check *utils.isEqual()* for more details.
The given options object accepts: [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) maxDeep.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisequalany-value1-any-value2-string-message-object-options)

### assert.isNotEqual(*Any* value1, *Any* value2, [*String* message, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotequalany-value1-any-value2-string-message-object-options)

### assert.instanceOf([*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) object, *Function* constructor, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertinstanceofobject-object-function-constructor-string-message)

### assert.notInstanceOf(*Any* object, *Function* constructor, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotinstanceofany-object-function-constructor-string-message)

### assert.lengthOf(*Any* value, [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) length, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertlengthofany-value-integer-length-string-message)

### assert.notLengthOf(*Any* value, [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) length, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotlengthofany-value-integer-length-string-message)

### assert.operator(*Any* value1, *String* operator, *Any* value2, [*String* message])

Used to compare the two given values.
```javascript
assert.operator(2, '>', 1);
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertoperatorany-value1-string-operator-any-value2-string-message)

### assert.match(*Any* value, *RegExp* regexp, [*String* message])

Used to check whether the given value tests the given regexp.
```javascript
assert.match('12', /[0-9]+/);
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertmatchany-value-regexp-regexp-string-message)

### assert.notMatch(*Any* value, *RegExp* regexp, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotmatchany-value-regexp-regexp-string-message)

