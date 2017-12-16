`// when=NEFT_NODE`

'use strict'

exports.allowsNoLine = true

exports.stdout = (msg) ->
    process.stdout.write msg
