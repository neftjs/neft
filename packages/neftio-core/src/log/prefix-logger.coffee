'use strict'

marker = require './marker'

exports.createLogger = (logger, prefix) ->
    prefixLogger = Object.create logger

    time = Date.now()

    getMsgWithPrefix = (msgBuilder) ->
        (ctx) ->
            marker.gray("[#{prefix}]  ", ctx) + msgBuilder(ctx)

    prefixLogger.print = (msgBuilder) ->
        logger.print getMsgWithPrefix msgBuilder
        @

    prefixLogger.println = (msgBuilder) ->
        logger.println getMsgWithPrefix msgBuilder
        @

    prefixLogger
