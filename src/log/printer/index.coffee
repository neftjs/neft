# coffeelint: disable=no_debugger

'use strict'

exports.allowsNoLine = false

exports.createContext = -> null

exports.stdout = (msg) ->
    console.log msg

loadCustomPrinter = (printer) ->
    for key, func of printer
        unless key of exports
            throw new Error "Unrecognized printer function '#{key}'"
        exports[key] = func
    return

if process.env.NEFT_BROWSER
    loadCustomPrinter require('./browser')
if process.env.NEFT_NODE
    loadCustomPrinter require('./node')
