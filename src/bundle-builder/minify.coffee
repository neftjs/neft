'use strict'

uglify = require 'uglify-js'

{log} = Neft

module.exports = (bundle, opts, callback) ->
    unless opts.minify
        return callback null, bundle

    logtime = log.time 'Minimalize'
    result = uglify.minify bundle,
        fromString: true
        mangle: true
        mangleProperties:
            reserved: ['Neft', '$', 'require', 'exports', 'module']
        compress:
            negate_iife: false
            keep_fargs: true
            screw_ie8: true
    log.end logtime

    callback null, result.code
