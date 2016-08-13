'use strict'

groundskeeper = require 'groundskeeper'

RELEASE_NAMESPACES_TO_REMOVE = [
    'assert', 'Object.freeze', 'Object.seal', 'Object.preventExtensions'
]
DEV_TAG_RE = ///\/\/<(\/)?development>;///g
PROD_TAG_RE = ///<production>([^]*?)<\/production>///gm

module.exports = (bundle, opts, callback) ->
    if opts.release
        namespaces = RELEASE_NAMESPACES_TO_REMOVE.slice()

        if opts.removeLogs
            namespaces.push 'log'

        bundle = bundle.replace DEV_TAG_RE, '//<$1development>'
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
        bundle = bundle.replace PROD_TAG_RE, ''

    callback null, bundle
