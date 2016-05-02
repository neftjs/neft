Unit @library
=============

    'use strict'

    utils = require 'src/utils'
    log = require 'src/log'
    stack = require './stack'
    logger = require './logger'
    modifiers = require './modifiers'

    {isArray} = Array
    {push} = Array::
    {Scope, Test, Listener} = require './structure'

    scopes = [new Scope]
    currentScope = scopes[0]

Unit.describe(*String* message, *Function* tests)
-------------------------------------------------

    exports.describe = (msg, func) ->
        beforeEach = utils.NOP

        # new scope
        scope = new Scope
        scope.message = msg
        scopes.push scope

        # before/after functions
        push.apply scope.beforeFunctions, currentScope.beforeFunctions
        push.apply scope.afterFunctions, currentScope.afterFunctions

        # save scope to parent
        currentScope.children.push scope
        scope.parent = currentScope

        # save as last
        currentScope = scope

        # filter children tests
        try
            func()
        catch err
            console.error err

        # set parent as last
        scopes.pop()
        currentScope = utils.last scopes
        return

    modifiers.applyAll exports.describe

Unit.it(*String* message, *Function* test)
------------------------------------------

The given test function can contains optional *callback* argument.

    exports.it = (msg, func) ->
        testScope = currentScope

        # new test
        test = new Test
        test.message = msg
        test.testFunction = func

        # add test into scope
        scope = utils.last scopes
        scope.children.push test
        test.parent = scope

        return

    modifiers.applyAll exports.it

Unit.beforeEach(*Function* code)
--------------------------------

    exports.beforeEach = (func) ->
        currentScope.beforeFunctions.push func
        return

    modifiers.applyAll exports.beforeEach

Unit.afterEach(*Function* code)
-------------------------------

    exports.afterEach = (func) ->
        currentScope.afterFunctions.push func
        return

    modifiers.applyAll exports.afterEach

Unit.whenChange(*Object* watchObject, *Function* callback, [*Integer* maxDelay = `1000`])
-----------------------------------------------------------------------------------------

    exports.whenChange = do ->
        listeners = []

        checkListeners = ->
            i = 0
            while i < listeners.length
                listener = listeners[i]

                if listener.test()
                    listeners.splice i, 1
                else
                    i++

            if listeners.length > 0
                setImmediate checkListeners
            return

        (obj, callback, maxDelay=1000) ->
            listener = new Listener
            listener.object = obj
            listener.objectCopy = utils.clone(obj)
            listener.callback = callback
            listener.maxDelay = maxDelay

            if listeners.length is 0
                setImmediate checkListeners

            listeners.push listener
            return

Unit.runTests()
---------------

    exports.runTests = ->
        [mainScope] = scopes
        mainScope.run ->
            logger.onTestsEnd()
            exports.onTestsEnd
                status: if stack.errors.length is 0 then 'success' else 'error'
                testsAmount: stack.testsAmount
                errors: stack.errors

*Function* Unit.onTestsEnd
--------------------------

    exports.onTestsEnd = (result) ->
        code = if result.status is 'success' then 0 else 1
        process.exit code

*Boolean* Unit.runAutomatically = true
--------------------------------------

    exports.runAutomatically = true

    setImmediate ->
        unless exports.runAutomatically
            return
        exports.runTests()
