'use strict'

fs = require 'fs-extra'

{utils, log} = Neft

module.exports = (options, callback) ->
    copy = (src) ->
        stack.add fs.copy, fs, [src, "#{out}/#{src}", {}]

    logLine = log.line().timer().repeat().loading 'Saving bundle...'

    {out} = options
    stack = new utils.async.Stack
    fs.ensureDirSync out
    stack.add fs.remove, fs, ["#{out}/(neft-*|app-*|build|static)"]

    if fs.existsSync('static')
        copy 'static'
    if fs.existsSync('build/static')
        copy 'build/static'

    mode = if options.release then 'release' else 'develop'
    copy "build/neft-node-#{mode}.js"
    copy "build/app-node-#{mode}.js"

    stack.runAll (err) ->
        if err
            logLine.error 'Cannot save bundle'
        else
            logLine.ok "Bundle saved into `#{out}`"
        logLine.stop()
        callback err
