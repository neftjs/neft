'use strict'

logger = require '../logger'

{log, signal, utils} = Neft

logByMsgPrefix = (prefix, methodName, msg) ->
    if msg.indexOf(prefix) is 0
        log[methodName] msg.slice(prefix.length)
        true
    else
        false

exports.verbose = false

exports.errors = Object.create null

exports.stats = Object.create null

exports.LogsReader = class LogsReader
    constructor: (@name) ->
        @terminated = false
        @finished = 0
        @amount = 0
        @errors = []
        unless exports.verbose
            @progressLog = log.line().timer().progress 0
            @testLog = log.line().log ''
        exports.stats[@name] = passed: 0, failed: 0
    log: (data) ->
        msg = String(data).trim()
        msg = msg.replace /^\n+|\n+$/g, ''
        unless msg
            return

        if msg.indexOf('\n') >= 0
            return msg.split('\n').forEach @log, @

        if msg.indexOf(logger.START) >= 0
            @amount = /([0-9]+) in total/.exec(msg)?[1] or '?'
            unless exports.verbose
                @progressLog.progress 0, @amount
        else if msg.indexOf(logger.TEST_START) >= 0
            testName = msg.slice(logger.TEST_START.length)
            if exports.verbose
                log.debug "Test `#{testName}`"
            else
                @testLog.log testName
        else if msg.indexOf(logger.TEST) >= 0
            testName = msg.slice(logger.TEST.length)
            @finished += 1
            exports.stats[@name].passed += 1
            if exports.verbose
                log.ok testName
            else
                @progressLog.progress @finished, @amount
        else if msg.indexOf(logger.ERROR_TEST) >= 0
            testName = msg.slice(logger.ERROR_TEST.length)
            @finished += 1
            exports.stats[@name].failed += 1
            log.error testName
            unless exports.verbose
                @progressLog.progress @finished, @amount
        else if msg.indexOf(logger.ERROR) >= 0
            errMsg = msg.slice logger.ERROR.length
            errMsg = try decodeURIComponent errMsg catch then errMsg
            errMsg = "\n#{errMsg}\n"
            # log.error errMsg
            @errors.push errMsg
            exports.errors[@name] ?= ''
            exports.errors[@name] += errMsg
        else if msg is logger.SUCCESS
            unless exports.verbose
                @progressLog.ok "**#{@name}** passed"
                @testLog.log ''
            @terminated = true
        else if msg is logger.FAILURE
            unless exports.verbose
                @progressLog.error "#{@name} failed"
                @testLog.log ''
            @terminated = true
        else if exports.verbose
            if logByMsgPrefix 'OK  ', 'ok', msg
                return
            else if logByMsgPrefix 'INFO  ', 'info', msg
                return
            else if logByMsgPrefix 'WARN  ', 'warn', msg
                return
            else if logByMsgPrefix 'ERROR  ', 'error', msg
                return
            else
                log.debug msg
