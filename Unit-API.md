Unit @library
=============

Unit.describe(*String* message, *Function* tests)
-------------------------------------------------

Unit.it(*String* message, *Function* test)
------------------------------------------

The given test function can contains optional *callback* argument.

Unit.beforeEach(*Function* code)
--------------------------------

Unit.afterEach(*Function* code)
-------------------------------

Unit.whenChange(*Object* watchObject, *Function* callback, [*Integer* maxDelay = `1000`])
-----------------------------------------------------------------------------------------

Unit.runTests()
---------------

*Function* Unit.onTestsEnd
--------------------------

*Boolean* Unit.runAutomatically = true
--------------------------------------

