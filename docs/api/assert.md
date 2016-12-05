# Assertions

> **API Reference** ▸ **Assertions**

<!-- toc -->
Access it with:
```javascript
const { assert } = Neft;
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee)


* * * 

### `assert()`

<dl><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws *AssertionError* if the given *expression* is falsy.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertboolean-expression-string-message)

## **Class** assert.AssertionError()

Access it with:
```javascript
const { AssertionError } = Neft.assert;
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee)


* * * 

### `assert.scope()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>message — <i>String</i></li></ul></dd><dt>Returns</dt><dd><i>assert</i></dd></dl>

Returns new assert namespace where all failues are prefixed by the given *message*.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assert-assertscopestring-message)


* * * 

### `assert.ok()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Link to the main assert function.

Throws an error if the given *expression* is falsy.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertokboolean-expression-string-message)


* * * 

### `assert.notOk()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>expression — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *expression* is truthy.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertnotokboolean-expression-string-message)


* * * 

### `assert.is()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>actual — <i>Any</i></li><li>expected — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *actual* is not the same as *expected*.

Strict comparison operator is used in this operation (`===`).
Types needs to be the same.
Read more about [comparison operators in JavaScript](https://developer.mozilla.org/en-US/docs
/Web/JavaScript/Reference/Operators/Comparison_Operators).


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisany-actual-any-expected-string-message)


* * * 

### `assert.isNot()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>actual — <i>Any</i></li><li>expected — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *actual* is the same as *expected*.

Strict comparison operator is used in this operation (`===`).


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotany-actual-any-expected-string-message)


* * * 

### `assert.isDefined()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is `null` or `undefined`.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisdefinedany-value-string-message)


* * * 

### `assert.isNotDefined()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is not `null` or `undefined`.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotdefinedany-value-string-message)


* * * 

### `assert.isPrimitive()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is not a primitive value.

Primitive value must be `null`, string, number, boolean or `undefined`.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisprimitiveany-value-string-message)


* * * 

### `assert.isNotPrimitive()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* if a primitive value.

Primitive value must be `null`, string, number, boolean or `undefined`.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotprimitiveany-value-string-message)


* * * 

### `assert.isString()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>String</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is not a string.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisstringstring-value-string-message)


* * * 

### `assert.isNotString()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is a string.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotstringany-value-string-message)


* * * 

### `assert.isFloat()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Float</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is not a float number.

Float number needs to be finite and may be an integer.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisfloatfloat-value-string-message)


* * * 

### `assert.isNotFloat()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is a float number.

Float number needs to be finite and may be an integer.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotfloatany-value-string-message)


* * * 

### `assert.isInteger()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Integer</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is not an integer.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisintegerinteger-value-string-message)


* * * 

### `assert.isNotInteger()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is an integer.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotintegerany-value-string-message)


* * * 

### `assert.isBoolean()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Boolean</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is not a boolean.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisbooleanboolean-value-string-message)


* * * 

### `assert.isNotBoolean()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is a boolean.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotbooleanany-value-string-message)


* * * 

### `assert.isFunction()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is not a function.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisfunctionfunction-value-string-message)


* * * 

### `assert.isNotFunction()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is a function.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotfunctionany-value-string-message)


* * * 

### `assert.isObject()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Object</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is not an object.

Arrays are objects.

`null` is not an object.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisobjectobject-value-string-message)


* * * 

### `assert.isNotObject()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is an object.

Arrays are objects.

`null` is not an object.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotobjectany-value-string-message)


* * * 

### `assert.isPlainObject()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>PlainObject</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is not a plain object.

Plain object in an object with no prototype or direct standard `Object` prototype.

Arrays and instances of classes are not plain objects.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisplainobjectplainobject-value-string-message)


* * * 

### `assert.isNotPlainObject()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is a plain object.

Plain object in an object with no prototype or direct standard `Object` prototype.

Arrays and instances of classes are not plain objects.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotplainobjectany-value-string-message)


* * * 

### `assert.isArray()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Array</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is not an array.

Typed arrays are not arrays.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisarrayarray-value-string-message)


* * * 

### `assert.isNotArray()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* is an array.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotarrayany-value-string-message)


* * * 

### `assert.isEqual()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given values are not equal.

Objects and arrays are tested recursively.

Maximum deepness may be specified by *options.maxDeep*.
Default value is `Infinity`.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisequalany-value1-any-value2-string-message-object-options)


* * * 

### `assert.isNotEqual()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given values are equal.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertisnotequalany-value1-any-value2-string-message-object-options)


* * * 

### `assert.instanceOf()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Object</i></li><li>constructor — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *object* is not an instance of the given *constructor*.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertinstanceofobject-object-function-constructor-string-message)


* * * 

### `assert.notInstanceOf()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>object — <i>Any</i></li><li>constructor — <i>Function</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *object* is an instance of the given *constructor*.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertnotinstanceofany-object-function-constructor-string-message)


* * * 

### `assert.lengthOf()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>length — <i>Integer</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* object `length` is not equal the given *length*.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertlengthofany-value-integer-length-string-message)


* * * 

### `assert.notLengthOf()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>length — <i>Integer</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *value* object `length` is equal the given *length*.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertnotlengthofany-value-integer-length-string-message)


* * * 

### `assert.operator()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value1 — <i>Any</i></li><li>operator — <i>String</i></li><li>value2 — <i>Any</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *operator* comparison is falsy on the given values.

*operator* is a string as follow: `>`, `>=`, `<`, or `<=`.
*TypeError* is thrown if unexpected *operator* has been given.

Example:

```javascript
assert.operator(2, '>', 1); // true
assert.operator(2, '<=', 1); // AssertionError
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertoperatorany-value1-string-operator-any-value2-string-message)


* * * 

### `assert.match()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>regexp — <i>RegExp</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *regexp* does not test on the given *value*.

Example:

```javascript
assert.match('12', /[0-9]+/); // true
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertmatchany-value-regexp-regexp-string-message)


* * * 

### `assert.notMatch()`

<dl><dt>Static method of</dt><dd><i>assert</i></dd><dt>Parameters</dt><dd><ul><li>value — <i>Any</i></li><li>regexp — <i>RegExp</i></li><li>message — <i>String</i> — <i>optional</i></li></ul></dd></dl>

Throws an error if the given *regexp* tests on the given *value*.


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/assert/index.litcoffee#assertnotmatchany-value-regexp-regexp-string-message)

