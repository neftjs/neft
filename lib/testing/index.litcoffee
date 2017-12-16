# Testing

    'use strict'

    {utils, log, assert} = Neft
    stack = require './stack'
    logger = require './logger'
    screenshot = require './screenshot/client'

    {isArray} = Array
    {push} = Array::
    {Scope, Test, Listener} = require './structure'

    scopes = [new Scope]
    currentScope = scopes[0]

    ONLY_OPT = 1 << 1

    raportOnlyUsed = ->
        if process.env.CI
            throw new Error "Cannot use describe.only and it.only on CI"
        else
            log.warn "describe.only or it.only is used"

# describe(*String* message, *Function* tests)

    exports.describe = (msg, func, opts = 0) ->
        beforeEach = utils.NOP

        # new scope
        scope = new Scope
        scope.message = msg
        if scope.isOnly = (opts & ONLY_OPT) > 0
            stack.onlyScopes += 1
        scopes.push scope

        # before/after functions
        push.apply scope.beforeFunctions, currentScope.beforeFunctions
        push.apply scope.afterFunctions, currentScope.afterFunctions

        # save scope to parent
        currentScope.children.push scope
        scope.parent = currentScope

        # save as last
        currentScope = scope

        # children tests
        func()

        # set parent as last
        scopes.pop()
        currentScope = utils.last scopes
        return

# describe.only(*String* message, *Function* tests)

    exports.describe.only = (msg, func) ->
        raportOnlyUsed()
        exports.describe msg, func, ONLY_OPT

# it(*String* message, *Function* test)

The given test function can contains optional *callback* argument.

    exports.it = (msg, func, opts = 0) ->
        testScope = currentScope

        # new test
        test = new Test
        test.message = msg
        test.testFunction = func
        if test.isOnly = (opts & ONLY_OPT) > 0
            stack.onlyTests += 1

        # add test into scope
        scope = utils.last scopes
        scope.children.push test
        test.parent = scope

        return

# it.only(*String* message, *Function* test)

    exports.it.only = (msg, func) ->
        raportOnlyUsed()
        exports.it msg, func, ONLY_OPT

# beforeEach(*Function* code)

    exports.beforeEach = (func) ->
        currentScope.beforeFunctions.push func
        return

# afterEach(*Function* code)

    exports.afterEach = (func) ->
        currentScope.afterFunctions.push func
        return

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
        assert.notOk currentTest.callbackCalled, """
            takeScreenshot called but current test '#{currentTest.getFullMessage()}' \
            is not pending
        """

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
        if process.env.NEFT_NODE
            # give logs some time to be printed int stdout
            setTimeout ->
                process.exit code
            , 1000

    runAutomatically = do ->
        val = process?.env.RUN_TESTS
        if typeof val is 'string'
            val = try JSON.parse val
        val ?= true
        val

    setImmediate ->
        if runAutomatically
            runTests()
