`// when=NEFT_NODE`

'use strict'

readline = require 'readline'

isWriting = false
lineLoggers = []

newLinesInString = (str) ->
    match = str.match /\n/g
    match?.length or 0

updateLineLoggersForString = (string) ->
    if isWriting or not string
        return
    {rows} = process.stdout
    offset = newLinesInString string
    return unless offset
    i = 0
    len = lineLoggers.length
    while i < len
        lineLogger = lineLoggers[i]

        # update leaving line loggers offsets
        lineLogger._rowOffset += offset

        # drop loggers out of view
        if lineLogger._rowOffset >= rows
            lineLogger.stop()
            len -= 1
            i -= 1

        i += 1
    return

do updateLineLoggersOnBuffersChange = ->
    [process.stdout, process.stderr, process.stdin].map (buffer) ->
        buffer.write = do (_super = buffer.write) -> (string, encoding, fd) ->
            updateLineLoggersForString String(string)
            _super.call buffer, string, encoding, fd

# Uncomment code below to keep tracking of logs when user hits new lines.
# This prevents to stop process automatically.
#
# do updateLineLoggersOnStdinChange = ->
#     process.stdin.setEncoding 'utf-8'
#     process.stdin.on 'readable', ->
#         updateLineLoggersForString process.stdin.read()

findLineLoggerIndex = (lineLogger) ->
    obj = lineLogger
    while obj
        index = lineLoggers.indexOf(obj)
        return if index isnt -1
        obj = Object.getPrototypeOf obj
    -1

stopLineLogger = (lineLogger) ->
    index = findLineLoggerIndex lineLogger
    return if index is -1

    # remove from unordered list
    lineLoggers[index] = lineLoggers[lineLoggers.length - 1]
    lineLoggers.pop()

    return

exports.createLogger = (logger) ->
    lineLogger = Object.create logger

    lineLogger._rowOffset = 0

    lineLogger.print = (msgBuilder) ->
        unless @_rowOffset
            logger.print msgBuilder
            return @
        isWriting = true
        readline.moveCursor process.stdout, 0, -@_rowOffset
        readline.clearLine process.stdout, 0
        logger.print msgBuilder
        readline.moveCursor process.stdout, 0, @_rowOffset
        readline.cursorTo process.stdout, 0
        isWriting = false
        @

    lineLogger.println = (msgBuilder) ->
        unless @_rowOffset
            logger.println msgBuilder
            return @

        # print updates with no new lines
        @print msgBuilder

        @

    lineLogger.stop = ->
        logger.stop()
        stopLineLogger @
        return

    lineLoggers.push lineLogger
    lineLogger
