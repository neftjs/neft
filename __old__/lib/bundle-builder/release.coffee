'use strict'

DEV_TAG_RE = ///<development>([^]*?)<\/development>///gm
PROD_TAG_RE = ///<production>([^]*?)<\/production>///gm

module.exports = (bundle, opts, callback) ->
    if opts.release
        bundle = bundle.replace DEV_TAG_RE, ''
    else
        bundle = bundle.replace PROD_TAG_RE, ''

    callback null, bundle
