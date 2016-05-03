Assert @library
===============

Access it with:
```javascript
var assert = require('assert');
```

assert(*Boolean* expression, [*String* message])
------------------------------------------------

*AssertionError* AssertionError()
---------------------------------

Access it with:
```javascript
var assert = require('assert');
var AssertionError = assert.AssertionError;
```

*assert* assert.scope(*String* message)
---------------------------------------

All fail messages will be prefixed by the given *message*.

assert.ok(*Boolean* expression, [*String* message])
---------------------------------------------------

assert.notOk(*Boolean* expression, [*String* message])
------------------------------------------------------

assert.is(*Any* actual, *Any* expected, [*String* message])
-----------------------------------------------------------

assert.isNot(*Any* actual, *Any* expected, [*String* message])
--------------------------------------------------------------

assert.isDefined(*Any* value, [*String* message])
-------------------------------------------------

Checks whether the given value is an undefined or a null.

assert.isNotDefined(*Any* value, [*String* message])
----------------------------------------------------

assert.isPrimitive(*Any* value, [*String* message])
---------------------------------------------------

Check [utils.isPrimitive()][utils/utils.isPrimitive()] for more details.

assert.isNotPrimitive(*Any* value, [*String* message])
------------------------------------------------------

assert.isString(*String* value, [*String* message])
---------------------------------------------------

assert.isNotString(*Any* value, [*String* message])
------------------------------------------------------

assert.isFloat(*Float* value, [*String* message])
-------------------------------------------------

assert.isNotFloat(*Any* value, [*String* message])
----------------------------------------------------

assert.isInteger(*Integer* value, [*String* message])
-----------------------------------------------------

assert.isNotInteger(*Any* value, [*String* message])
--------------------------------------------------------

assert.isBoolean(*Boolean* value, [*String* message])
-----------------------------------------------------

assert.isNotBoolean(*Any* value, [*String* message])
-----------------------------------------------------

assert.isFunction(*Function* value, [*String* message])
-------------------------------------------------------

assert.isNotFunction(*Any* value, [*String* message])
-----------------------------------------------------

assert.isObject(*Object* value, [*String* message])
---------------------------------------------------

assert.isNotObject(*Any* value, [*String* message])
---------------------------------------------------

assert.isPlainObject(*PlainObject* value, [*String* message])
-------------------------------------------------------------

Check [utils.isPlainObject()][utils/utils.isPlainObject()] for more details.

assert.isNotPlainObject(*Any* value, [*String* message])
--------------------------------------------------------

assert.isArray(*Array* value, [*String* message])
-------------------------------------------------

assert.isNotArray(*Any* value, [*String* message])
--------------------------------------------------

assert.isEqual(*Any* value1, *Any* value2, [*String* message, *Object* options])
--------------------------------------------------------------------------------

Check [utils.isEqual()][utils/utils.isEqual()] for more details.

The given options object accepts: *Integer* maxDeep.

assert.isNotEqual(*Any* value1, *Any* value2, [*String* message, *Object* options])
-----------------------------------------------------------------------------------

assert.instanceOf(*Object* object, *Function* constructor, [*String* message])
------------------------------------------------------------------------------

assert.notInstanceOf(*Any* object, *Function* constructor, [*String* message])
------------------------------------------------------------------------------

assert.lengthOf(*Any* value, *Integer* length, [*String* message])
------------------------------------------------------------------

assert.notLengthOf(*Any* value, *Integer* length, [*String* message])
---------------------------------------------------------------------

assert.operator(*Any* value1, *String* operator, *Any* value2, [*String* message])
----------------------------------------------------------------------------------

Used to compare the two given values.

```javascript
assert.operator(2, '>', 1);
```

assert.match(*Any* value, *RegExp* regexp, [*String* message])
--------------------------------------------------------------

Used to check whether the given value tests the given regexp.

```javascript
assert.match('12', /[0-9]+/);
```

assert.notMatch(*Any* value, *RegExp* regexp, [*String* message])
-----------------------------------------------------------------

