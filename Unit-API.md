> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Unit @library**

Unit @library
=============

> [`Source`](/Neft-io/neft/tree/master/src/unit/index.litcoffee#unit-library)

## Table of contents
  * [Unit.describe(message, tests)](#unitdescribestring-message-function-tests)
  * [Unit.it(message, test)](#unititstring-message-function-test)
  * [Unit.beforeEach(code)](#unitbeforeeachfunction-code)
  * [Unit.afterEach(code)](#unitaftereachfunction-code)
  * [Unit.whenChange(watchObject, callback, [maxDelay])](#unitwhenchangeobject-watchobject-function-callback-integer-maxdelay--1000)
  * [Unit.runTests()](#unitruntests)
  * [Unit.onTestsEnd](#function-unitontestsend)
  * [Unit.runAutomatically = true](#boolean-unitrunautomatically--true)

Unit.describe(*String* message, *Function* tests)
-------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/unit/index.litcoffee#unitdescribestring-message-function-tests)

Unit.it(*String* message, *Function* test)
------------------------------------------

The given test function can contains optional *callback* argument.

> [`Source`](/Neft-io/neft/tree/master/src/unit/index.litcoffee#unititstring-message-function-test)

Unit.beforeEach(*Function* code)
--------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/unit/index.litcoffee#unitbeforeeachfunction-code)

Unit.afterEach(*Function* code)
-------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/unit/index.litcoffee#unitaftereachfunction-code)

Unit.whenChange(*Object* watchObject, *Function* callback, [[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) maxDelay = `1000`])
-----------------------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/unit/index.litcoffee#unitwhenchangeobject-watchobject-function-callback-integer-maxdelay--1000)

Unit.runTests()
---------------

> [`Source`](/Neft-io/neft/tree/master/src/unit/index.litcoffee#unitruntests)

*Function* Unit.onTestsEnd
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/unit/index.litcoffee#function-unitontestsend)

*Boolean* Unit.runAutomatically = true
--------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/unit/index.litcoffee#boolean-unitrunautomatically--true)

