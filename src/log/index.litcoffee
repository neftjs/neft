# Log

    'use strict'

    parser = require './parser'
    marker = require './marker'
    printer = require './printer'
    lineLogger = try require './line-logger'
    repeatLogger = require './repeat-logger'
    timerLogger = require './timer-logger'
    prefixLogger = require './prefix-logger'

    DEFAULT_SCOPE = 'debug'
    LOADING_MSG = 'Loading...'
    LOADING_FRAMES = ['⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷']

    # https://github.com/darkskyapp/string-hash
    getStringHash = (str) ->
        hash = 5381
        i = str.length
        while(i)
            hash = (hash * 33) ^ str.charCodeAt(--i)
        hash >>> 0

    getStringColor = (str) ->
        hash = getStringHash str
        hex = hash.toString 16
        validHex = "000000#{hex}".slice(-6)
        "##{validHex}"

    class Logger
        constructor: (@scopeName = DEFAULT_SCOPE) ->
            @scopeColor = getStringColor @scopeName
            @_loadingFrame = 0

        stop: ->

        print: (msgBuilder) ->
            ctx = printer.createContext()
            printer.stdout msgBuilder(ctx), ctx
            @

        println: (msgBuilder) ->
            ctx = printer.createContext()
            msg = msgBuilder(ctx)
            if printer.allowsNoLine
                msg += '\n'
            printer.stdout msg, ctx
            @

        line: ->
            lineLogger?.createLogger(@) or @

        repeat: (opts) ->
            if process.env.CI
                @
            else
                repeatLogger.createLogger @, opts

        timer: ->
            timerLogger.createLogger @

        prefix: (prefix) ->
            prefixLogger.createLogger @, prefix

        scope: (name) ->
            childScope = if @scopeName is DEFAULT_SCOPE then '' else "#{@scopeName}:"
            childScope += name
            new Logger childScope

        log: (msg) ->
            @println (ctx) -> parser.parse(msg, ctx)

        debug: (msg) ->
            @println (ctx) =>
                marker.hex(@scopeName, @scopeColor, ctx) + '  ' + parser.parse(msg, ctx)

        info: (msg) ->
            @println (ctx) ->
                marker.blue(marker.bold('INFO', ctx), ctx) + '  ' + parser.parse(msg, ctx)

        ok: (msg) ->
            @println (ctx) ->
                marker.green(marker.bold('OK', ctx), ctx) + '  ' + parser.parse(msg, ctx)

        warn: (msg) ->
            @println (ctx) ->
                marker.yellow(marker.bold('WARN', ctx), ctx) + '  ' + parser.parse(msg, ctx)

        error: (msg) ->
            @println (ctx) ->
                marker.red(marker.bold('ERROR', ctx), ctx) + '  ' + parser.parse(msg, ctx)

        progress: (title, value, max) ->
            if typeof title is 'number'
                max = value
                value = title
                title = ''
            width = process.stdout.columns / 3 - parser.clear(title).length
            if max is undefined
                value = Math.floor value * 100
                max = 100
                label = "#{value}%"
            else
                label = "#{value}/#{max}"
            left = '█'.repeat(Math.min(width, Math.floor(value / max * width)))
            right = '░'.repeat(Math.max(0, width - left.length))
            @println (ctx) ->
                titleMsg = if title then "#{parser.parse(title, ctx)}  " else ''
                "#{titleMsg}#{left}#{marker.gray right, ctx} #{label}"

        loading: (msg = LOADING_MSG, frames = LOADING_FRAMES) ->
            @println (ctx) =>
                frame = frames[@_loadingFrame++ % frames.length]
                marker.cyan(frame, ctx) + ' ' + parser.parse(msg, ctx)

    module.exports = new Logger
