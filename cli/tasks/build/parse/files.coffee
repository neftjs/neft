'use strict'

fs = require 'fs'
pathUtils = require 'path'

cliUtils = require 'cli/utils'
utils = require 'src/utils'
log = require 'src/log'

FOLDERS = [
    {name: 'routes', dir: 'routes'},
    {name: 'scripts', dir: 'build/scripts'}
]

getFolderLinks = (dir, callback) ->
    links = []

    fs.exists dir, (exists) ->
        # break if not dir found
        unless exists
            return callback null, links

        cliUtils.forEachFileDeep dir, (path, stat) ->
            # get file name
            if name = /(.+)\.[a-z]+(\.md)?$/i.exec(path)
                [_, name] = name
            else
                name = path

            name = name.slice dir.length + 1

            links.push
                name: name
                path: path
        , (err) ->
            callback err, links

saveFolderLinks = (opts, target, callback) ->
    getFolderLinks opts.dir, (err, links) ->
        target[opts.name] = links
        callback err

module.exports = (platform, app, callback) ->
    logLine = log.line().timer().loading 'Link files'
    stack = new utils.async.Stack

    for folder in FOLDERS
        stack.add saveFolderLinks, null, [folder, app]

    stack.runAllSimultaneously (err) ->
        if err
            logLine.errr 'Cannot link files'
        else
            logLine.ok """
                Files linked _(#{app.routes.length} routes and #{app.scripts.length} scripts)_
            """
        callback err
