'use strict'

fs = require 'fs'
pathUtils = require 'path'
yaml = require 'js-yaml'
Module = require 'module'

process.neftBundleBuilder =
    terminateWhenPossible: true

# parse json opts from
optsString = new Buffer(process.argv[2], 'base64').toString()
opts = JSON.parse optsString, (key, val) ->
    if val and val._function
        eval "(#{val._function})"
    else
        val

index = pathUtils.resolve fs.realpathSync('.'), opts.path
{platform, test, testResolved, path} = opts
test ?= -> true
testResolved ?= -> true

customGlobalProps = Object.create null
mockGlobal = (obj) ->
    for key, val of obj
        customGlobalProps[key] = global[key]
        global[key] = val
    return

base = pathUtils.dirname index

mockGlobal require("./emulators/#{platform}") opts

if opts.neftFilePath
    global.Neft = require opts.neftFilePath
    Neft.log.enabled = 0
else
    global.Neft = ->

require.extensions['.pegjs'] = require.extensions['.txt'] = (module, filename) ->
    module.exports = fs.readFileSync filename, 'utf8'
require.extensions['.yaml'] = (module, filename) ->
    module.exports = yaml.safeLoad fs.readFileSync filename, 'utf8'

# register babel
if opts.useBabel
    require('lib/moduleCache').registerBabel()

modules = []
modulesByPaths = {}
paths = {}

# clear cache
for key of cache = Module._cache
    delete cache[key]

###
Override standard `Module._load()` to capture all required modules and files
###
disabled = false
Module = module.constructor
Module._load = do (_super = Module._load) -> (req, parent) ->
    if Neft[req]
        return Neft[req]

    disabledHere = false

    if not disabled and req isnt index and not test(req)
        disabled = true
        disabledHere = true
    r = _super.call @, req, parent
    if disabled
        if disabledHere
            disabled = false
        return r

    filename = Module._resolveFilename req, parent
    modulePath = pathUtils.relative base, filename
    parentPath = pathUtils.relative base, parent.id

    if req is index or testResolved(req, filename, modulePath, parentPath)
        unless modulesByPaths[modulePath]
            modules.push modulePath
            modulesByPaths[modulePath] = true

        if parentPath
            mpaths = paths[parentPath] ?= {}
            mpaths[req] = modulePath

    r

# run index file
try
    require index
catch err
    if err.stack
        err = err.stack
    else
        err += ''
    console.error err
    process.exit 1

{setImmediate} = require('timers')

setImmediate terminate = ->
    unless process.neftBundleBuilder.terminateWhenPossible
        return setTimeout terminate

    resultJSON = JSON.stringify
        modules: modules
        paths: paths

    process.send resultJSON

process.on 'message', (msg) ->
    if msg is 'terminate'
        process.exit()
