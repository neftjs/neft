'use strict'

###
TryCatch is an internal module used to catch application exceptions.
Each call into application code needs to be wrapped in this module.
###

signal = require 'src/signal'

exports.onError = signal.create()

exports.tryCall = (func, context, args) ->
    try
        return func.apply context, args
    catch err
        try console.error err # coffeelint: disable=no_debugger
        try exports.onError.emit err
    return
