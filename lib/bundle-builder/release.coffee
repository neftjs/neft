'use strict'

groundskeeper = require 'groundskeeper'

DEV_TAG_RE = ///\/\/<(\/)?development>;///g
PROD_TAG_RE = ///<production>([^]*?)<\/production>///gm

module.exports = (bundle, opts, callback) ->
    if opts.release
        bundle = bundle.replace DEV_TAG_RE, '//<$1development>'
        cleaner = groundskeeper
            console: true
            replace: 'true\n'
        cleaner.write bundle
        bundle = cleaner.toString()
    else
        bundle = bundle.replace PROD_TAG_RE, ''

    callback null, bundle
