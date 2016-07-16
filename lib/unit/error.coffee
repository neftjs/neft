'use strict'

exports.toString = (err) ->
    msg = ''
    if err.stack
        msg += err.stack

        unitStackIndex = msg.indexOf '/lib/unit/stack.coffee'
        if unitStackIndex >= 0
            msg = msg.slice(0, unitStackIndex) + '…'
    else
        msg += err
    msg += '\n'
    msg
