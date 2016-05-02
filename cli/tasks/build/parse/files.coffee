'use strict'

fs = require 'fs'
pathUtils = require 'path'

cliUtils = require '../../../utils'

{utils, log} = Neft

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
        target[opts.dir] = links
        callback err

module.exports = (platform, app, callback) ->
    logtime = log.time 'Link files'
    stack = new utils.async.Stack

    stack.add saveFolderLinks, null, [dir: 'routes', app]
    stack.add saveFolderLinks, null, [dir: 'models', app]

    stack.runAllSimultaneously (err) ->
        log.end logtime
        callback err
