> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Assertions**

# Assertions

Access it with:
```javascript
const { assert } = Neft;
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertions)

## Table of contents
  * [assert(expression, [message])](#assertboolean-expression-string-message)
    * [**Class** assert.AssertionError()](#class-assertassertionerror)
    * [assert.scope(message)](#assert-assertscopestring-message)
    * [assert.ok(expression, [message])](#assertokboolean-expression-string-message)
    * [assert.notOk(expression, [message])](#assertnotokboolean-expression-string-message)
    * [assert.is(actual, expected, [message])](#assertisany-actual-any-expected-string-message)
    * [assert.isNot(actual, expected, [message])](#assertisnotany-actual-any-expected-string-message)
    * [assert.isDefined(value, [message])](#assertisdefinedany-value-string-message)
    * [assert.isNotDefined(value, [message])](#assertisnotdefinedany-value-string-message)
    * [assert.isPrimitive(value, [message])](#assertisprimitiveany-value-string-message)
    * [assert.isNotPrimitive(value, [message])](#assertisnotprimitiveany-value-string-message)
    * [assert.isString(value, [message])](#assertisstringstring-value-string-message)
    * [assert.isNotString(value, [message])](#assertisnotstringany-value-string-message)
    * [assert.isFloat(value, [message])](#assertisfloatfloat-value-string-message)
    * [assert.isNotFloat(value, [message])](#assertisnotfloatany-value-string-message)
    * [assert.isInteger(value, [message])](#assertisintegerinteger-value-string-message)
    * [assert.isNotInteger(value, [message])](#assertisnotintegerany-value-string-message)
    * [assert.isBoolean(value, [message])](#assertisbooleanboolean-value-string-message)
    * [assert.isNotBoolean(value, [message])](#assertisnotbooleanany-value-string-message)
    * [assert.isFunction(value, [message])](#assertisfunctionfunction-value-string-message)
    * [assert.isNotFunction(value, [message])](#assertisnotfunctionany-value-string-message)
    * [assert.isObject(value, [message])](#assertisobjectobject-value-string-message)
    * [assert.isNotObject(value, [message])](#assertisnotobjectany-value-string-message)
    * [assert.isPlainObject(value, [message])](#assertisplainobjectplainobject-value-string-message)
    * [assert.isNotPlainObject(value, [message])](#assertisnotplainobjectany-value-string-message)
    * [assert.isArray(value, [message])](#assertisarrayarray-value-string-message)
    * [assert.isNotArray(value, [message])](#assertisnotarrayany-value-string-message)
    * [assert.isEqual(value1, value2, [message, options])](#assertisequalany-value1-any-value2-string-message-object-options)
    * [assert.isNotEqual(value1, value2, [message, options])](#assertisnotequalany-value1-any-value2-string-message-object-options)
    * [assert.instanceOf(object, constructor, [message])](#assertinstanceofobject-object-function-constructor-string-message)
    * [assert.notInstanceOf(object, constructor, [message])](#assertnotinstanceofany-object-function-constructor-string-message)
    * [assert.lengthOf(value, length, [message])](#assertlengthofany-value-integer-length-string-message)
    * [assert.notLengthOf(value, length, [message])](#assertnotlengthofany-value-integer-length-string-message)
    * [assert.operator(value1, operator, value2, [message])](#assertoperatorany-value1-string-operator-any-value2-string-message)
    * [assert.match(value, regexp, [message])](#assertmatchany-value-regexp-regexp-string-message)
    * [assert.notMatch(value, regexp, [message])](#assertnotmatchany-value-regexp-regexp-string-message)

## assert(*Boolean* expression, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertboolean-expression-string-message)

### **Class** assert.AssertionError()

Access it with:
```javascript
const { AssertionError } = Neft.assert;
```

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#class-assertassertionerror)

### *assert* assert.scope(*String* message)

All fail messages will be prefixed by the given *message*.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assert-assertscopestring-message)

### assert.ok(*Boolean* expression, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertokboolean-expression-string-message)

### assert.notOk(*Boolean* expression, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotokboolean-expression-string-message)

### assert.is(*Any* actual, *Any* expected, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisany-actual-any-expected-string-message)

### assert.isNot(*Any* actual, *Any* expected, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotany-actual-any-expected-string-message)

### assert.isDefined(*Any* value, [*String* message])

Checks whether the given value is an undefined or a null.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisdefinedany-value-string-message)

### assert.isNotDefined(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotdefinedany-value-string-message)

### assert.isPrimitive(*Any* value, [*String* message])

Check *utils.isPrimitive()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisprimitiveany-value-string-message)

### assert.isNotPrimitive(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotprimitiveany-value-string-message)

### assert.isString(*String* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisstringstring-value-string-message)

### assert.isNotString(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotstringany-value-string-message)

### assert.isFloat(*Float* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfloatfloat-value-string-message)

### assert.isNotFloat(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfloatany-value-string-message)

### assert.isInteger(*Integer* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisintegerinteger-value-string-message)

### assert.isNotInteger(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotintegerany-value-string-message)

### assert.isBoolean(*Boolean* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisbooleanboolean-value-string-message)

### assert.isNotBoolean(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotbooleanany-value-string-message)

### assert.isFunction(*Function* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisfunctionfunction-value-string-message)

### assert.isNotFunction(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotfunctionany-value-string-message)

### assert.isObject(*Object* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisobjectobject-value-string-message)

### assert.isNotObject(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotobjectany-value-string-message)

### assert.isPlainObject(*PlainObject* value, [*String* message])

Check *utils.isPlainObject()* for more details.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisplainobjectplainobject-value-string-message)

### assert.isNotPlainObject(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotplainobjectany-value-string-message)

### assert.isArray(*Array* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisarrayarray-value-string-message)

### assert.isNotArray(*Any* value, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotarrayany-value-string-message)

### assert.isEqual(*Any* value1, *Any* value2, [*String* message, *Object* options])

Check *utils.isEqual()* for more details.
The given options object accepts: *Integer* maxDeep.

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisequalany-value1-any-value2-string-message-object-options)

### assert.isNotEqual(*Any* value1, *Any* value2, [*String* message, *Object* options])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertisnotequalany-value1-any-value2-string-message-object-options)

### assert.instanceOf(*Object* object, *Function* constructor, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertinstanceofobject-object-function-constructor-string-message)

### assert.notInstanceOf(*Any* object, *Function* constructor, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertnotinstanceofany-object-function-constructor-string-message)

### assert.lengthOf(*Any* value, *Integer* length, [*String* message])

> [`Source`](/Neft-io/neft/tree/master/src/assert/index.litcoffee#assertlengthofany-value-integer-length-string-message)

### assert.notLengthOf(*Any* value, *Integer* length, [*String* message])

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

