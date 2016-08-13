'use strict'

groundskeeper = require 'groundskeeper'

RELEASE_NAMESPACES_TO_REMOVE = [
    'assert', 'Object.freeze', 'Object.seal', 'Object.preventExtensions'
]

module.exports = (bundle, opts, callback) ->
    if opts.release
        namespaces = RELEASE_NAMESPACES_TO_REMOVE.slice()

        if opts.removeLogs
            namespaces.push 'log'

        bundle = bundle.replace ///\/\/<(\/)?development>;///g, '//<$1development>'
        bundle = bundle.replace /, assert,;/g, ', '
        bundle = bundle.replace /\ assert, |, assert;/g, ' '
        if opts.removeLogs
            bundle = bundle.replace /, log,;/g, ', '
            bundle = bundle.replace /\ log, |, log;/g, ' '
        cleaner = groundskeeper
            console: true
            namespace: namespaces
            replace: 'true\n'
        cleaner.write bundle
        bundle = cleaner.toString()
    else
        bundle = bundle.replace ///<production>([^]*?)<\/production>///gm, ''

    callback null, bundle
