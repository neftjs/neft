'use strict'

fs = require 'fs-extra'
utils = require 'src/utils'
log = require 'src/log'
notify = require './notify'
parseApp = require './parse'
createBundle = require './bundle'
saveBundle = require './saveBundle'

log = log.scope 'build'
Log = Neft.log.constructor

module.exports = (platform, options, callback) ->
    log.info platform

    # create build folder
    fs.ensureDirSync './build'

    stack = new utils.async.Stack
    args = [platform, options, null]

    # create temporary 'index.js' file
    stack.add ((platform, options, callback) ->
        parseApp platform, options, (err, app) ->
            args[2] = app
            callback err
    ), null, args

    # create bundle files
    stack.add createBundle, null, args

    # save output if needed
    if options.out
        stack.add saveBundle, null, args

    # notify
    callback = do (callback) -> (err) ->
        if options.notify or err?
            notify err
        callback err

    # run
    stack.runAll (err) ->
        if err
            log.error err?.stack or err
            log.error platform
        else
            log.ok platform
        callback err
