'use strict'

readline = require 'readline'
pathUtils = require 'path'
fs = require 'fs'

{log, assert} = Neft
Log = log.constructor
{MARKERS} = Log

DEST = 'tests_results'
STDOUT_PATH = pathUtils.join DEST, 'stdout.txt'
STDERR_PATH = pathUtils.join DEST, 'stderr.txt'
IS_VERBOSE = !!process.env.CI

logs = []
groups = Object.create null

stdout = ''
stderr = ''
lastLogs = ''

Log::_write = (msg) ->
    msg += '\n'
    stdout += msg
    if IS_VERBOSE
        process.stdout.write msg
    return

Log::_writeError = (msg) ->
    msg += '\n\n'
    stderr += msg
    clearLogs()
    process.stdout.write msg
    writeLogs()
    return

Log.MARKERS = log.Log.MARKERS

clearLogs = ->
    if IS_VERBOSE
        return

    length = 0
    width = process.stdout.columns

    # get length
    lineWidth = 0
    for char in lastLogs
        lineWidth += 1
        if char is '\n' or lineWidth > width
            length += 1
            lineWidth = 0

    # move cursor
    readline.moveCursor process.stdout, 0, -length

    # get blank line
    line = ''
    for i in [0...width]
        line += ' '
    line += '\n'

    # clear all moved lines
    for i in [0...length]
        process.stdout.write line

    # move again to the start
    readline.moveCursor process.stdout, 0, -length
    return

writeLogs = ->
    if IS_VERBOSE
        return

    text = logs.join '\n'
    text += '\n'

    process.stdout.write text
    lastLogs = text

    return

refreshLogs = ->
    clearLogs()
    writeLogs()
    return

noNewLines = (str) ->
    str.replace /\n/g, ''

getGroupLog = (group, msg) ->
    assert.isDefined groups[group]
    groupConfig = groups[group]

    groupText = groupConfig.text
    if msg
        groupText += ': '

    text = MARKERS.bold groupText
    text += msg

    MARKERS[groupConfig.color] noNewLines text

changeGroupLog = (group, msg) ->
    assert.isDefined groups[group]
    assert.isString msg

    groupConfig = groups[group]
    logMsg = getGroupLog group, msg
    logs[groupConfig.index] = logMsg

    refreshLogs()

    return

exports.changeGroup = (group, text, color) ->
    clearLogs()

    if groups[group] is undefined
        groups[group] =
            text: ''
            color: color ? 'white'
            index: logs.length
        logs.push ''

    groupConfig = groups[group]
    groupConfig.text = noNewLines text
    groupConfig.color = color if color
    logs[groupConfig.index] = getGroupLog group, ''

    if IS_VERBOSE and color?
        process.stdout.write logs[groupConfig.index] + '\n'
    else
        writeLogs()
    return

exports.log = (group, msg) ->
    assert.isString msg
    changeGroupLog group, msg

exports.saveOutput = ->
    try fs.unlinkSync STDOUT_PATH
    if stdout
        fs.writeFileSync STDOUT_PATH, stdout

    try fs.unlinkSync STDERR_PATH
    if stderr
        fs.writeFileSync STDERR_PATH, stderr

    return
