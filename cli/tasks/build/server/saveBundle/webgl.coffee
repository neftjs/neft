'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
mustache = require 'mustache'

{utils, log} = Neft

module.exports = (options, callback) ->
    copy = (src) ->
        stack.add fs.copy, fs, [src, "#{out}/#{src}", {}]

    logtime = log.time 'Save bundle'

    {out} = options
    stack = new utils.async.Stack
    fs.ensureDirSync out
    stack.add fs.remove, fs, ["#{out}/(neft-*|app-*|build|static)"]

    mode = if options.release then 'release' else 'develop'
    neftFilePath = "build/neft-webgl-#{mode}.js"
    appFilePath = "build/app-webgl-#{mode}.js"

    # index file
    indexFilePath = pathUtils.join __dirname, './webgl/index.mustache'
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
        log.end logtime
        callback err
