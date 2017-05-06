'use strict'

exports.toString = (err) ->
    msg = ''
    if err.stack
        # remove internal testing methods from stack
        stack = []
        for line in err.stack.split('\n')
            if line.indexOf('__callNeftTestingFunction__') >= 0
                break
            stack.push line
        msg += stack.join '\n'
    else if err.name? and err.message?
        msg += "#{err.name}: #{err.message}"
    else
        msg += JSON.stringify err
    msg
