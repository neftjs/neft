# coffeelint: disable=no_debugger

exports.createContext = ->
    styles: []

###
Prints given msg with styles defined in `ctx.styles`.
`msg` describes start of a style with `%c` and ends with `%r`.
###
exports.stdout = (msg, ctx) ->
    styledMsg = ''
    args = []
    stylesStack = []
    nextStyle = 0
    for char, i in msg
        if i > 0 and msg[i - 1] is '%'
            if char is 'c'
                stylesStack.push ctx.styles[nextStyle++]
            if char is 'r'
                char = 'c'
                stylesStack.pop()
            args.push stylesStack.join(';')
        styledMsg += char
    console.log styledMsg, args...
    return
