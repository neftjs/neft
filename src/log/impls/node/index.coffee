'use strict'

writeStdout = process.stdout.write.bind process.stdout
writeStderr = process.stderr.write.bind process.stderr

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
        writeStdout msg + '\n'

    _writeError: (msg) ->
        writeStderr msg + '\n'
