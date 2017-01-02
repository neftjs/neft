# Testing

    'use strict'

    {utils, log} = Neft
    stack = require './stack'
    logger = require './logger'
    modifiers = require './modifiers'
    screenshot = require './screenshot/client'

    {isArray} = Array
    {push} = Array::
    {Scope, Test, Listener} = require './structure'

    scopes = [new Scope]
    currentScope = scopes[0]

# describe(*String* message, *Function* tests)

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

# it(*String* message, *Function* test)

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

# beforeEach(*Function* code)

    exports.beforeEach = (func) ->
        currentScope.beforeFunctions.push func
        return

    modifiers.applyAll exports.beforeEach

# afterEach(*Function* code)

    exports.afterEach = (func) ->
        currentScope.afterFunctions.push func
        return

    modifiers.applyAll exports.afterEach

# whenChange(*Object* watchObject, *Function* callback, [*Integer* maxDelay = `1000`])

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

        (obj, callback, maxDelay = 1000) ->
            listener = new Listener
            listener.object = obj
            listener.objectCopy = utils.clone(obj)
            listener.callback = callback
            listener.maxDelay = maxDelay

            if listeners.length is 0
                setImmediate checkListeners

            listeners.push listener
            return

# takeScreenshot(*String|Object* options, [*Function* callback])

    screenshotInitialized = false
    exports.takeScreenshot = (opts, callback) ->
        if typeof opts is 'string'
            opts = expected: opts

        unless opts?.expected
            throw new Error "'expected' path not set in takeScreenshot"

        {currentTest} = Test
        currentTest.preventEnding = true

        endCurrentTest = (err) ->
            callback? err
            currentTest.preventEnding = false
            currentTest.onEnd err

        unless screenshotInitialized
            screenshotInitialized = true
            screenshot.initialize (err) ->
                if err
                    endCurrentTest err
                else
                    exports.takeScreenshot opts, callback
            return

        screenshot.take opts, endCurrentTest
        return

    runTests = ->
        [mainScope] = scopes
        logger.onTestsStart()
        mainScope.run ->
            logger.onTestsEnd()
            onTestsEnd
                status: if stack.errors.length is 0 then 'success' else 'error'
                testsAmount: stack.testsAmount
                errors: stack.errors

    onTestsEnd = (result) ->
        code = if result.status is 'success' then 0 else 1
        if utils.isServer
            process.exit code

    runAutomatically = do ->
        val = process?.env.RUN_TESTS
        if typeof val is 'string'
            val = try JSON.parse val
        val ?= true
        val

    setImmediate ->
        if runAutomatically
            runTests()
