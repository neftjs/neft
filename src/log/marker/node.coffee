`// when=NEFT_NODE`

'use strict'

chalk = require 'chalk'

bind = (func) ->
    (str) ->
        func str

exports.bold = bind chalk.bold
exports.italic = bind chalk.italic
exports.strikethrough = bind chalk.strikethrough
exports.underline = bind chalk.underline
exports.code = bind chalk.yellow

exports.red = bind chalk.red
exports.green = bind chalk.green
exports.yellow = bind chalk.yellow
exports.blue = bind chalk.blue
exports.white = bind chalk.white
exports.cyan = bind chalk.cyan
exports.gray = bind chalk.gray
exports.hex = (str, hex) -> chalk.hex(hex) str
