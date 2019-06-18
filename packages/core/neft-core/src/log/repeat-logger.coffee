'use strict'

DEFAULT_DELAY = 100

exports.createLogger = (logger, opts) ->
    repeatLogger = Object.create logger
    delay = opts?.delay or DEFAULT_DELAY

    printTasks = []
    printlnTasks = []
    timer = undefined
    updating = false

    updateTasks = ->
        updating = true
        for task in printTasks
            logger.print task
        for task in printlnTasks
            logger.println task
        updating = false
        return

    repeatLogger.print = (msgBuilder) ->
        printTasks.push msgBuilder
        logger.print msgBuilder
        @

    repeatLogger.println = (msgBuilder) ->
        printlnTasks.push msgBuilder
        logger.println msgBuilder
        @

    repeatLogger.stop = ->
        logger.stop()
        clearInterval timer
        timer = undefined
        return

    timer = setInterval updateTasks, delay
    repeatLogger
