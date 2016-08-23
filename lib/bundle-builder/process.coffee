'use strict'

fs = require 'fs'
pathUtils = require 'path'
yaml = require 'js-yaml'
Module = require 'module'

TEXT_EXTNAMES = ['.txt', '.pegjs']

paths = {}

module.exports = (opts, callback) ->
    # prepare environment
    unless opts.watch
        paths = {}

    # remove changed files from cache
    if opts.watch and opts.changedFiles
        cache = Module._cache
        for file in opts.changedFiles
            delete cache[file]
            delete paths[file]

    # extend global namespace by platform properties
    MOCK_KEYS = Object.create null
    for key, val of require("./emulators/#{opts.platform}") opts
        MOCK_KEYS[key] = global[key]
        global[key] = val

    # get config
    INDEX_PATH = opts.path
    BASE_DIR = pathUtils.dirname INDEX_PATH
    TEST = opts.test or -> true
    TEST_RESOLVED = opts.testResolved or -> true

    # capture requires
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
            unless opts.watch
                filenames.push filename

            if parentPath
                mpaths = paths[parent.id] ?= {}
                mpaths[req] = filename

        r

    # require index file
    try
        require INDEX_PATH
    catch err
        callback err

    # remove require files from cache
    unless opts.watch
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
            paths: paths

    return
