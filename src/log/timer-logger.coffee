'use strict'

marker = require './marker'

exports.createLogger = (logger) ->
    timerLogger = Object.create logger

    time = Date.now()

    getMsgWithTime = (msgBuilder) ->
        (ctx) ->
            change = Date.now() - time
            unit = 'ms'
            if change > 1000
                change = (change / 1000).toFixed(1)
                unit = 's'
                if change > 60
                    change = (change / 60).toFixed(2)
                    unit = 'm'
            msgBuilder(ctx) + ' ' + marker.cyan("+#{change}#{unit}", ctx)

    timerLogger.print = (msgBuilder) ->
        logger.print getMsgWithTime msgBuilder
        @

    timerLogger.println = (msgBuilder) ->
        logger.println getMsgWithTime msgBuilder
        @

    timerLogger
