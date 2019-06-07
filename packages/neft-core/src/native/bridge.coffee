'use strict'

utils = require '../util'
log = require '../log'
assert = require '../assert'
eventLoop = require '../event-loop'

listeners = Object.create null

reader =
    booleans: null
    booleansIndex: 0
    integers: null
    integersIndex: 0
    floats: null
    floatsIndex: 0
    strings: null
    stringsIndex: 0
    getBoolean: ->
        `//<development>`
        if @booleansIndex >= @booleans.length
            throw new Error """
                Index #{@booleansIndex} out of range for native booleans array
            """
        `//</development>`
        @booleans[@booleansIndex++]
    getInteger: ->
        `//<development>`
        if @integersIndex >= @integers.length
            throw new Error """
                Index #{@booleansIndex} out of range for native integers array
            """
        `//</development>`
        @integers[@integersIndex++]
    getFloat: ->
        `//<development>`
        if @floatsIndex >= @floats.length
            throw new Error """
                Index #{@booleansIndex} out of range for native floats array
            """
        `//</development>`
        @floats[@floatsIndex++]
    getString: ->
        `//<development>`
        if @stringsIndex >= @strings.length
            throw new Error """
                Index #{@booleansIndex} out of range for native strings array
            """
        `//</development>`
        @strings[@stringsIndex++]
Object.preventExtensions reader

exports.onData = (actions, booleans, integers, floats, strings) ->
    reader.booleans = booleans
    reader.booleansIndex = 0
    reader.integers = integers
    reader.integersIndex = 0
    reader.floats = floats
    reader.floatsIndex = 0
    reader.strings = strings
    reader.stringsIndex = 0

    eventLoop.lock()
    for action in actions
        func = listeners[action]
        try
            assert.isFunction func, "unknown native action got '#{action}'"
            func reader
        catch error
            log.error 'Uncaught error when processing native events', error
    eventLoop.release()

    exports.sendData()
    return

exports.addActionListener = (action, listener) ->
    assert.isInteger action
    assert.isFunction listener
    assert.isNotDefined listeners[action], "action '#{action}' already has a listener"

    listeners[action] = listener
    return

exports.sendData = ->

exports.pushAction = (val) ->

exports.pushBoolean = (val) ->

exports.pushInteger = (val) ->

exports.pushFloat = (val) ->

exports.pushString = (val) ->

exports.registerNativeFunction = () ->

exports.publishNativeEvent = () ->

exports.sendDataInLock = ->
    exports.sendData()

if process.env.NEFT_ANDROID
    impl = require './impl/android/bridge'
if process.env.NEFT_IOS
    impl = require './impl/ios/bridge'
if process.env.NEFT_MACOS
    impl = require './impl/macos/bridge'
if process.env.NEFT_BROWSER
    impl = require './impl/browser/bridge'
if impl?
    utils.merge exports, impl(exports)

`//<development>`
exports.pushAction = do (_super = exports.pushAction) -> (val) ->
    assert.isInteger val, "integer expected, but '#{val}' given"
    _super val
    return
exports.pushBoolean = do (_super = exports.pushBoolean) -> (val) ->
    assert.isBoolean val, "boolean expected, but '#{val}' given"
    _super val
    return
exports.pushInteger = do (_super = exports.pushInteger) -> (val) ->
    assert.isInteger val, "integer expected, but '#{val}' given"
    _super val
    return
exports.pushFloat = do (_super = exports.pushFloat) -> (val) ->
    assert.isFloat val, "float expected, but '#{val}' given"
    _super val
    return
exports.pushString = do (_super = exports.pushString) -> (val) ->
    assert.isString val, "string expected, but '#{val}' given"
    _super val
    return
`//</development>`
