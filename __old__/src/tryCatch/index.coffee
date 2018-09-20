'use strict'

###
TryCatch is an internal module used to catch application exceptions.
Each call into application code needs to be wrapped in this module.
###

signal = require 'src/signal'
log = require 'src/log'

exports.onError = signal.create()

exports.tryCall = (func, context, args) ->
    try
        return func.apply context, args
    catch err
        log.error "Uncaught error showed up", err
        try exports.onError.emit err
    return
