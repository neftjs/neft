`// when=NEFT_NODE`

'use strict'

readline = require 'readline'
{stdout, stderr} = process

showedMessage = ''

module.exports = (Log) -> class LogNode extends Log
    @MARKERS =
        white: (str) -> "\u001b[37m#{str}\u001b[39m"
        green: (str) -> "\u001b[32m#{str}\u001b[39m"
        gray: (str) -> "\u001b[90m#{str}\u001b[39m"
        blue: (str) -> "\u001b[34m#{str}\u001b[39m"
        yellow: (str) -> "\u001b[33m#{str}\u001b[39m"
        red: (str) -> "\u001b[31m#{str}\u001b[39m"
        bold: (str) -> "\u001b[1m#{str}\u001b[22m"

    @time = process.hrtime
    @timeDiff = (since) ->
        diff = process.hrtime since
        (diff[0] * 1e9 + diff[1]) / 1e6

    _write: (msg) ->
        if showedMessage
            readline.clearLine stdout, 0
            readline.cursorTo stdout, 0
        stdout.write msg + '\n'
        if showedMessage
            stdout.write showedMessage

    _writeError: (msg) ->
        stderr.write msg + '\n'

    _show: (msg) ->
        if process.env.CI
            stdout.write msg + '\n'
        else
            showedMessage = msg
            readline.clearLine stdout, 0
            readline.cursorTo stdout, 0
            stdout.write msg

    _commit: ->
        showedMessage = ''
        stdout.write '\n'
