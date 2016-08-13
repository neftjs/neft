'use strict'

uglify = require 'uglify-js'

module.exports = (bundle, opts, callback) ->
    unless opts.minify
        return callback null, bundle

    result = uglify.minify bundle,
        fromString: true
        mangle: true
        mangleProperties:
            reserved: ['Neft', '$', 'require', 'exports', 'module']
        compress:
            negate_iife: false
            keep_fargs: true
            screw_ie8: true

    callback null, result.code
