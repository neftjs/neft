'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
driver = require './driver'
findWindow = require './server/findWindow'
testScreenshot = require './server/testScreenshot'
server = require '../server'

{utils, log} = Neft

DEST = 'tests_results'
INITIALIZATION_FILE_PATH = pathUtils.join DEST, 'initialization.png'

fs.emptyDirSync DEST

rects = {}

getPathWithBasename = (path, basename) ->
    pathUtils.format utils.mergeAll {}, pathUtils.parse(path),
        name: basename
        base: undefined

getErrorFileUri = (path) ->
    if process.env.LOG_SCREENSHOT_DATA_URI
        file = fs.readFileSync path
        base64 = new Buffer(file).toString 'base64'
        return "data:image/png;base64,#{base64}"
    path

getScreenshotError = (opts) ->
    diffUri = do ->
        if fs.existsSync(opts.diff)
            getErrorFileUri opts.diff
        else
            'not found; image widths or heights differ'
    expectedUri = do ->
        if fs.existsSync(opts.expected)
            getErrorFileUri opts.expected
        else
            'not found'
    new Error """
        Screenshot doesn't match with expected;
        Path: #{getErrorFileUri opts.path}
        Diff: #{diffUri}
        Expected: #{expectedUri}
    """

server.onInitializeScreenshots ({clientUid}) ->
    log "🎞  Initialize screenshots"

    unless driver
        throw new Error "Screenshots on this platform are not supported"

    opts = path: INITIALIZATION_FILE_PATH
    driver.takeScreenshot opts
    rect = findWindow opts
    unless rect
        throw new Error "Cannot find application on screenshot; check '#{opts.path}' file"
    rects[clientUid] = rect
    return

server.onScreenshot (opts) ->
    log "🎞  Take screenshot"
    path = pathUtils.parse opts.expected
    opts.name ?= path.name
    opts.path = getPathWithBasename pathUtils.join(DEST, path.base), path.name
    opts.diff = getPathWithBasename opts.path, "#{path.name}_diff"
    opts.rect = rects[opts.clientUid]

    driver.takeScreenshot opts
    if testScreenshot(opts)
        fs.unlinkSync opts.diff
        fs.unlinkSync opts.path
    else
        expectedCopyPath = getPathWithBasename opts.path, "#{path.name}_expected"
        try fs.copySync opts.expected, expectedCopyPath
        throw getScreenshotError opts
    return
