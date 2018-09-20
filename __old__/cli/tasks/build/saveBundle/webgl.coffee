'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
mustache = require 'mustache'

{utils, log} = Neft

module.exports = (options, callback) ->
    copy = (src) ->
        stack.add fs.copy, fs, [src, "#{out}/#{src}", {}]

    logLine = log.line().timer().repeat().loading 'Saving bundle...'

    {out} = options
    stack = new utils.async.Stack
    fs.ensureDirSync out
    stack.add fs.remove, fs, ["#{out}/(neft-*|app-*|build|static)"]

    mode = if options.release then 'release' else 'develop'
    neftFilePath = "build/neft-webgl-#{mode}.js"
    appFilePath = "build/app-webgl-#{mode}.js"

    # index file
    indexFilePath = pathUtils.join __dirname, './html/index.mustache'
    indexFile = fs.readFileSync indexFilePath, 'utf-8'
    indexFile = mustache.render indexFile,
        neftFilePath: neftFilePath
        appFilePath: appFilePath
    stack.add fs.writeFile, fs, ["#{out}/index.html", indexFile]

    # static files
    if fs.existsSync('static')
        copy 'static'
    if fs.existsSync('build/static')
        copy 'build/static'

    # js files
    copy neftFilePath
    copy appFilePath

    stack.runAll (err) ->
        if err
            logLine.error 'Cannot save bundle'
        else
            logLine.ok "Bundle saved into `#{out}`"
        callback err
