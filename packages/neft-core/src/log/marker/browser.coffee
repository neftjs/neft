`// when=NEFT_BROWSER`

'use strict'

styleMsg = (msg, context, style) ->
    context.styles.push style
    "%c#{msg}%r"

withStyle = (style) ->
    (msg, context) ->
        styleMsg msg, context, style

exports.bold = withStyle 'font-weight:bold'
exports.italic = withStyle 'font-style:italic'
exports.strikethrough = withStyle 'text-decoration:line-through'
exports.underline = withStyle 'text-decoration:underline'
exports.code = withStyle '''
    padding: 2px 4px;\
    font-size: 90%;\
    color: #c7254e;\
    background-color: #f9f2f4;\
    border-radius: 4px
'''

exports.red = withStyle 'color:red'
exports.green = withStyle 'color:green'
exports.yellow = withStyle 'color:orange'
exports.blue = withStyle 'color:blue'
exports.white = withStyle 'color:white'
exports.cyan = withStyle 'color:#00caca'
exports.gray = withStyle 'color:gray'
exports.hex = (msg, hex, context) ->
    styleMsg msg, context, "color:#{hex}"
