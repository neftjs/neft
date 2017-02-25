'use strict'

uglify = require 'uglify-js'
log = require 'src/log'
assert = require 'src/assert'

module.exports = (bundle, opts, callback) ->
    unless opts.minify
        return callback null, bundle

    pureFuncs = Object.create null

    if opts.release
        pureFuncs['Object.freeze'] = true
        pureFuncs['Object.seal'] = true
        pureFuncs['Object.preventExtensions'] = true
        pureFuncs['assert'] = true
        for key of assert
            pureFuncs["assert.#{key}"] = true
    if opts.removeLogs
        pureFuncs['log'] = true
        for key of log
            pureFuncs["log.#{key}"] = true

    result = uglify.minify bundle,
        fromString: true
        warnings: true
        # output:
        #     beautify: true
        mangle:
            except: ['Neft', 'require', 'exports', 'module', 'process']
            toplevel: true
        compress:
            negate_iife: false
            sequences: true
            properties: true
            dead_code: true
            drop_debugger: true
            drop_console: true
            pure_funcs: (node) ->
                expr = node.expression.print_to_string()
                not pureFuncs[expr]
            unsafe: false
            conditionals: true
            comparisons: true
            evaluate: true
            booleans: true
            loops: true
            unused: true
            hoist_funs: true
            hoist_vars: false
            if_return: true
            join_vars: true
            cascade: true
            side_effects: true
            warnings: false
            global_defs: {}

    callback null, result.code
