'use strict'

{utils} = Neft
stack = require './stack'
logger = require './logger'

ASYNC_TEST_TIMEOUT = 5000

class Scope
    constructor: ->
        @parent = null
        @message = ''
        @children = []
        @beforeFunctions = []
        @afterFunctions = []
        @isOnly = false
        Object.seal @

    run: do ->
        forEachCallback = (child, i, arr, callback) ->
            stack.currentScope = @
            child.run callback

        (callback) ->
            Object.freeze @
            logger.onScopeStart @
            utils.async.forEach @children, forEachCallback, ->
                logger.onScopeEnd @
                callback()
            , @
            return

class Test
    @currentTest = null

    constructor: ->
        @_callback = null
        @callbackCalled = false
        @context = {}
        @parent = null
        @fulfilled = true
        @message = ''
        @testFunction = utils.NOP
        @onDone = null
        @onEnd = utils.bindFunctionContext @onEnd, @
        @preventEnding = false
        @isOnly = false
        Object.seal @

    onEnd: (err) ->
        if @callbackCalled
            return

        if @preventEnding
            return

        @callbackCalled = true

        if err
            logger.onTestError @, err
            stack.fail err

        stack.testsAmount += 1
        logger.onTestEnd @

        # call after functions
        for afterFunc in stack.currentScope.afterFunctions
            stack.callFunction afterFunc, @context

        @_callback()

        return

    run: (callback) ->
        if not @isOnly and stack.onlyTests + stack.onlyScopes > 0
            shouldRun = false
            if stack.onlyScopes > 0
                scope = @parent
                while scope
                    if scope.isOnly
                        shouldRun = true
                        break
                    scope = scope.parent
            unless shouldRun
                return callback null

        stack.currentTest = @
        @_callback = callback

        logger.onTestStart @
        Test.currentTest = @

        # call before functions
        for beforeFunc in stack.currentScope.beforeFunctions
            stack.callFunction beforeFunc, @context

        # call test function
        if @testFunction.length is 0
            stack.callFunction @testFunction, @context
            @onEnd()
        else
            setTimeout =>
                @onEnd new Error "timeout of #{ASYNC_TEST_TIMEOUT}ms exceeded"
            , ASYNC_TEST_TIMEOUT
            stack.callFunction @testFunction, @context, [@onEnd]

        return

    getFullMessage: ->
        str = @message
        scope = @
        while scope = scope.parent
            if message = scope.message
                str = "#{message} #{str}"
        str

class Listener
    constructor: ->
        @object = null
        @objectCopy = null
        @callback = null
        @maxDelay = 1000
        @createTimestamp = Date.now()
        Object.seal @

    test: ->
        if not utils.isEqual(@object, @objectCopy, 1)
            unless stack.callFunction(@callback)
                stack.currentTest.onEnd()
            return true

        if @maxDelay > 0 and Date.now() - @createTimestamp > @maxDelay
            stack.fail new Error 'unit.whenChange waits too long'
            stack.currentTest.onEnd()
            return true

        false

exports.Scope = Scope
exports.Test = Test
exports.Listener = Listener
