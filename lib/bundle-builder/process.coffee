'use strict'

fs = require 'fs'
pathUtils = require 'path'
yaml = require 'js-yaml'
Module = require 'module'

TEXT_EXTNAMES = ['.txt', '.pegjs']

module.exports = (opts, callback) ->
    # extend global namespace by platform properties
    MOCK_KEYS = Object.create null
    for key, val of require("./emulators/#{opts.platform}") opts
        MOCK_KEYS[key] = global[key]
        global[key] = val

    # get config
    INDEX_PATH = pathUtils.resolve fs.realpathSync('.'), opts.path
    BASE_DIR = pathUtils.dirname INDEX_PATH
    TEST = opts.test or -> true
    TEST_RESOLVED = opts.testResolved or -> true

    # capture requires
    modules = []
    modulesByPaths = {}
    paths = {}
    filenames = []
    disabled = false
    moduleLoad = Module._load
    Module._load = do (_super = Module._load) -> (req, parent, isMain) ->
        disabledHere = false

        if not disabled and req isnt INDEX_PATH and not TEST(req)
            disabled = true
            disabledHere = true
        r = _super.call @, req, parent, isMain
        if disabled
            if disabledHere
                disabled = false
            return r

        filename = Module._resolveFilename req, parent, isMain
        modulePath = pathUtils.relative BASE_DIR, filename
        parentPath = pathUtils.relative BASE_DIR, parent.id

        shouldInclude = req is INDEX_PATH
        shouldInclude ||= TEST_RESOLVED(req, filename, modulePath, parentPath)
        if shouldInclude
            filenames.push filename
            unless modulesByPaths[modulePath]
                modules.push modulePath
                modulesByPaths[modulePath] = true

            if parentPath
                mpaths = paths[parentPath] ?= {}
                mpaths[req] = modulePath

        r

    # require index file
    try
        require INDEX_PATH
    catch err
        callback err

    # remove require files from cache
    cache = Module._cache
    for filename in filenames
        delete cache[filename]

    # clear global namespace from mock data
    for key, val of MOCK_KEYS
        if val is undefined
            delete global[key]
        else
            global[key] = val

    # restore native functions
    Module._load = moduleLoad

    unless err
        callback null,
            modules: modules
            paths: paths

    return
