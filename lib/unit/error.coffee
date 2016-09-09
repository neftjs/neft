'use strict'

STACK_FILE_PATH = 'lib/unit/stack.coffee'

if process?.platform is 'win32'
    STACK_FILE_PATH = STACK_FILE_PATH.replace /\//g, '\\'

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
