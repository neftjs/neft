'use strict'

fs = require 'fs-extra'
utils = require 'src/utils'
log = require 'src/log'
notify = require './notify'
parseApp = require './parse'
createBundle = require './bundle'
saveBundle = require './saveBundle'
hotReloader = require './hotReloader'

log = log.scope 'build'
Log = Neft.log.constructor

module.exports = (platform, options, callback) ->
    log.info platform

    # create build folder
    fs.ensureDirSync './build'

    stack = new utils.async.Stack
    result =
        stats: {}
        destChangedFiles: []
        hotReloads: null
    args = [platform, options, null, result]

    # create temporary 'index.js' file
    stack.add ((platform, options, callback) ->
        parseApp platform, options, (err, app) ->
            args[2] = app
            callback err
    ), null, args

    # build or hot reload
    stack.add ((platform, options, app, result, callback) ->
        hotReloader.prepare options, result, (err) ->
            if err
                return callback err

            if options.watch and hotReloader.canUse(platform, options, result)
                result.hotReloads = []
                hotReloader.resolve platform, options, result, callback
            else
                substack = new utils.async.Stack

                # create bundle files
                substack.add createBundle, null, args

                # save output if needed
                if options.out
                    substack.add saveBundle, null, args

                substack.runAll callback
    ), null, args

    # notify
    callback = do (callback) -> (err) ->
        if options.notify or err?
            notify err
        if err?
            callback err, options.lastResult
        else
            callback null, result

    # run
    stack.runAll (err) ->
        if err
            if err?.message then log.error err.message
            if err?.stack then log.error err.stack
            if not err?.message and not err?.stack
                log.error err
            log.error platform
        else
            log.ok platform
        callback err
