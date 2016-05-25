'use strict'

exports.toString = (err) ->
    msg = ''
    if err.stack
        msg += err.stack

        unitStackIndex = msg.indexOf '/neft-cli/src/unit/'
        if unitStackIndex >= 0
            msg = msg.slice(0, unitStackIndex) + '…'
    else
        msg += err
    msg += "\n"
    msg
