'use strict'

pathUtils = require 'path'

STACK_FILE_PATH = ['lib', 'unit', 'stack.coffee'].join(pathUtils.sep)

exports.toString = (err) ->
    msg = ''
    if err.stack
        msg += err.stack

        unitStackIndex = msg.indexOf STACK_FILE_PATH
        if unitStackIndex >= 0
            msg = msg.slice(0, unitStackIndex) + '…'
    else
        msg += err
    msg += '\n'
    msg
