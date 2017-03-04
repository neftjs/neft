'use strict'

logger = require '../logger'

{log, signal} = Neft

LOG_PREFIX = '   '

exports.errors = Object.create null

exports.passingTests = Object.create null

exports.LogsReader = class LogsReader
    constructor: (@name) ->
        @error = null
        @terminated = false
        exports.passingTests[@name] = 0
    log: (data) ->
        msg = String(data).trim()
        unless msg
            return

        if msg.indexOf('\n') >= 0
            return msg.split('\n').forEach @log, @

        if msg.indexOf(logger.SCOPE) >= 0
            log LOG_PREFIX + msg.slice(logger.SCOPE.length)
        else if msg.indexOf(logger.TEST) >= 0
            log.ok LOG_PREFIX + msg.slice(logger.TEST.length)
            exports.passingTests[@name] += 1
        else if msg.indexOf(logger.ERROR_TEST) >= 0
            msg = msg.slice(logger.ERROR_TEST.length)
            log.error LOG_PREFIX + msg
        else if msg.indexOf(logger.ERROR) >= 0
            errMsg = msg.slice logger.ERROR.length
            errMsg = try decodeURIComponent errMsg catch then errMsg
            @error = new Error errMsg
            errMsg = "\n#{errMsg}\n"
            log.error errMsg
            exports.errors[@name] ?= ''
            exports.errors[@name] += errMsg
        else if msg is logger.SUCCESS
            @terminated = true
        else if msg is logger.FAILURE
            @terminated = true
            @error = new Error logger.FAILURE
        else
            log.debug LOG_PREFIX + msg
