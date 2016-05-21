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
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertboolean-expression-string-message)

### **Class** assert.AssertionError()

Access it with:
```javascript
const { AssertionError } = Neft.assert;
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#class-assertassertionerror)

###scope
All fail messages will be prefixed by the given *message*.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assert-assertscopestring-message)

###ok
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertokboolean-expression-string-message)

###notOk
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotokboolean-expression-string-message)

###is
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisany-actual-any-expected-string-message)

###isNot
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotany-actual-any-expected-string-message)

###isDefined
Checks whether the given value is an undefined or a null.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisdefinedany-value-string-message)

###isNotDefined
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotdefinedany-value-string-message)

###isPrimitive
Check *utils.isPrimitive()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisprimitiveany-value-string-message)

###isNotPrimitive
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotprimitiveany-value-string-message)

###isString
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisstringstring-value-string-message)

###isNotString
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotstringany-value-string-message)

###isFloat
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfloatfloat-value-string-message)

###isNotFloat
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfloatany-value-string-message)

###isInteger
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisintegerinteger-value-string-message)

###isNotInteger
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotintegerany-value-string-message)

###isBoolean
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisbooleanboolean-value-string-message)

###isNotBoolean
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotbooleanany-value-string-message)

###isFunction
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfunctionfunction-value-string-message)

###isNotFunction
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfunctionany-value-string-message)

###isObject
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisobjectobject-value-string-message)

###isNotObject
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotobjectany-value-string-message)

###isPlainObject
Check *utils.isPlainObject()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisplainobjectplainobject-value-string-message)

###isNotPlainObject
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotplainobjectany-value-string-message)

###isArray
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisarrayarray-value-string-message)

###isNotArray
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotarrayany-value-string-message)

###isEqual
Check *utils.isEqual()* for more details.
The given options object accepts: [*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) maxDeep.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisequalany-value1-any-value2-string-message-object-options)

###isNotEqual
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotequalany-value1-any-value2-string-message-object-options)

###instanceOf
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertinstanceofobject-object-function-constructor-string-message)

###notInstanceOf
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotinstanceofany-object-function-constructor-string-message)

###lengthOf
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertlengthofany-value-integer-length-string-message)

###notLengthOf
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotlengthofany-value-integer-length-string-message)

###operator
Used to compare the two given values.
```javascript
assert.operator(2, '>', 1);
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertoperatorany-value1-string-operator-any-value2-string-message)

###match
Used to check whether the given value tests the given regexp.
```javascript
assert.match('12', /[0-9]+/);
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertmatchany-value-regexp-regexp-string-message)

###notMatch
> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotmatchany-value-regexp-regexp-string-message)

