'use strict'

noMarker = (msg) -> msg

exports.bold = noMarker
exports.italic = noMarker
exports.strikethrough = noMarker
exports.underline = noMarker
exports.code = noMarker

exports.red = noMarker
exports.green = noMarker
exports.yellow = noMarker
exports.blue = noMarker
exports.white = noMarker
exports.cyan = noMarker
exports.gray = noMarker
exports.hex = noMarker

canUseBrowser = navigator?
canUseBrowser and= /chrome|safari|firefox/i.test(navigator.userAgent)
canUseBrowser and= not /edge/i.test(navigator.userAgent)

loadCustomMarker = (marker) ->
    for key, func of marker
        unless exports[key]
            throw new Error "Unrecognized marker function '#{key}'"
        exports[key] = func
    return

if process.env.NEFT_BROWSER
    if canUseBrowser
        loadCustomMarker require('./browser')
if process.env.NEFT_NODE
    loadCustomMarker require('./node')
