'use strict'

fs = require 'fs-extra'

{utils, log} = Neft

linkFiles = require './parse/files'
linkStyles = require './parse/styles'
linkDocuments = require './parse/documents'
linkResources = require './parse/resources'
createIndexFile = require './parse/index'

module.exports = (platform, options, callback) ->
    stack = new utils.async.Stack

    app = Object.preventExtensions
        extensions: []
        models: []
        routes: []
        views: []
        styles: []
        styleQueries: []
        scripts: []
        resources: null
        config: null

    stack.add linkStyles, null, [platform, app]
    stack.add linkDocuments, null, [platform, app]
    stack.add linkFiles, null, [platform, app]
    stack.add linkResources, null, [platform, app]

    stack.runAll (err) ->
        if err
            return callback err

        file = createIndexFile platform, app, options
        fs.writeFileSync './index.js', file, 'utf-8'

        callback null, app
