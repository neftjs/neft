'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
glob = require 'glob'
utils = require 'src/utils'
log = require 'src/log'

linkFiles = require './parse/files'
linkStyles = require './parse/styles'
linkDocuments = require './parse/documents'
linkResources = require './parse/resources'
createIndexFile = require './parse/index'

NEFT_EXTENSIONS = do ->
    extensionsPath = pathUtils.join __dirname, '../../../../extensions/'
    paths = glob.sync "#{extensionsPath}*"
    for path, i in paths
        paths[i] = path.slice extensionsPath.length
    paths

module.exports = (platform, options, callback) ->
    stack = new utils.async.Stack

    app = Object.preventExtensions
        package: JSON.parse fs.readFileSync('./package.json')
        allExtensions: []
        extensions: []
        models: []
        routes: []
        views: []
        styles: []
        styleQueries: []
        scripts: []
        resources: null
        config: null

    # get neft defined extensions
    packageExtensions = app.package.extensions
    if packageExtensions is undefined
        packageExtensions = NEFT_EXTENSIONS
    if Array.isArray(packageExtensions)
        for ext in packageExtensions
            path = pathUtils.resolve __dirname, "../../../../extensions/#{ext}"
            unless fs.existsSync(path)
                log.error "Neft extension #{ext} defined in package.json not found"
            app.allExtensions.push
                name: ext
                path: path

    # get module extensions
    try
        modules = fs.readdirSync './node_modules'
        for path in modules
            if /^neft\-/.test(path)
                app.allExtensions.push
                    name: path.slice('neft-'.length)
                    path: "./node_modules/#{path}/"

    # get local extensions
    try
        extensions = fs.readdirSync './extensions'
        for path in extensions
            app.allExtensions.push
                name: path
                path: "./extensions/#{path}/"

    stack.add linkStyles, null, [platform, app]
    stack.add linkDocuments, null, [platform, app]
    stack.add linkFiles, null, [platform, app]
    stack.add linkResources, null, [platform, app]

    stack.runAll (err) ->
        if err
            return callback err

        file = createIndexFile platform, app, options
        fs.writeFileSync './build/index.js', file, 'utf-8'

        callback null, app
