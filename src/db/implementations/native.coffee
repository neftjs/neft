`// when=NEFT_NATIVE`

'use strict'

utils = require 'src/utils'
{callNativeFunction, onNativeEvent} = require 'src/native'

lastId = 0
callbacks = Object.create null

onNativeEvent '__neftDbResponse', (id, error, result) ->
    callbacks[id]? error, result
    delete callbacks[id]

registerCallback = (callback) ->
    callbacks[lastId] = callback
    lastId += 1
    lastId %= 99999

encodeKey = (key) -> encodeURIComponent String(key)

exports.get = (key, callback) ->
    callNativeFunction '__neftDbGet', encodeKey(key), lastId
    registerCallback (error, result) ->
        if error
            error = new Error error
        result = utils.tryFunction JSON.parse, null, [result], result
        callback error, result

exports.set = (key, val, callback) ->
    if utils.isObject(val)
        try
            val = JSON.stringify val
        catch error
            return callback error
    callNativeFunction '__neftDbSet', encodeKey(key), String(val), lastId
    registerCallback callback

exports.remove = (key, callback) ->
    callNativeFunction '__neftDbRemove', encodeKey(key), lastId
    registerCallback callback
