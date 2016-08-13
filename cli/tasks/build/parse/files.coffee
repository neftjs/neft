'use strict'

fs = require 'fs'
pathUtils = require 'path'

cliUtils = require '../../../utils'

{utils, log} = Neft

FOLDERS = [
    {name: 'routes', dir: 'routes'},
    {name: 'models', dir: 'models'},
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
                path: "./#{path}"
        , (err) ->
            callback err, links

saveFolderLinks = (opts, target, callback) ->
    getFolderLinks opts.dir, (err, links) ->
        target[opts.name] = links
        callback err

module.exports = (platform, app, callback) ->
    logtime = log.time 'Link files'
    stack = new utils.async.Stack

    for folder in FOLDERS
        stack.add saveFolderLinks, null, [folder, app]

    stack.runAllSimultaneously (err) ->
        log.end logtime
        callback err
