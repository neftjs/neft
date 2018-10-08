'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
childProcess = require 'child_process'
driver = require './driver'
findWindow = require './server/findWindow'
testScreenshot = require './server/testScreenshot'
server = require '../server'
targets = require '../cli/targets'

{utils, log} = Neft

DEST = 'tests_results'
INITIALIZATION_FILE_PATH = pathUtils.join DEST, 'initialization.png'
SCREENSHOT_TRIES = 100
SCREENSHOT_TRY_DELAY_SEC = 0.2
CUSTOM_SCREENSHOT_MAX_DELAY_MS = 2000
{LOG_SCREENSHOT_DATA_URI} = process.env

if LOG_SCREENSHOT_DATA_URI
    imgur = require 'imgur'
    imgur.setClientId '2ea624e59d38a21'

fs.emptyDirSync DEST

rects = {}

exports.verbose = false

getPathWithBasename = (path, basename) ->
    pathUtils.format utils.mergeAll {}, pathUtils.parse(path),
        name: basename
        base: undefined

getErrorFileUri = (path) ->
    if LOG_SCREENSHOT_DATA_URI
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

waitForScreenshot = (path, maxDelay) ->
    startTime = Date.now()
    itertion = 0
    while Date.now() < startTime + maxDelay
        try
            stats = fs.statSync path
            if stats?.size
                return true
        childProcess.execSync "sleep 0.1"
    return false

takeScreenshot = (opts) ->
    # use target-specified screenshot function
    if opts.env
        handler = targets.getEnvHandler(opts.env)
        handler.focusWindow?()
        if handler.takeScreenshot
            startTime = Date.now()
            handler.takeScreenshot opts
            maxDelay = handler.TAKE_SCREENSHOT_DELAY_MS ? CUSTOM_SCREENSHOT_MAX_DELAY_MS
            if waitForScreenshot(opts.path, maxDelay)
                return
            else
                log.warn """
                    #{opts.env.platform} custom screenshot handler failed; \
                    waited #{maxDelay} ms for a file; \
                    the whole screen is captured
                """

    # take the whole screen screenshot
    driver.takeScreenshot opts
    waitForScreenshot(opts.path, CUSTOM_SCREENSHOT_MAX_DELAY_MS)
    return

tryTakeScreenshot = (opts, isOk) ->
    tryNo = 0
    while tryNo++ < SCREENSHOT_TRIES
        takeScreenshot opts
        if result = isOk(opts)
            return result
        childProcess.execSync "sleep #{SCREENSHOT_TRY_DELAY_SEC}"
    undefined

server.onInitializeScreenshots (opts) ->
    if exports.verbose
        log.log "🎞  Initialize screenshots"

    fs.emptyDirSync DEST

    unless driver
        throw new Error "Screenshots on this platform are not supported"

    if opts.env
        handler = targets.getEnvHandler(opts.env)
        handler.onInitializeScreenshots? opts.env

    opts.path = INITIALIZATION_FILE_PATH
    rect = tryTakeScreenshot opts, findWindow

    if LOG_SCREENSHOT_DATA_URI
        imgur.uploadFile(INITIALIZATION_FILE_PATH)
            .then (json) -> log.info "Initialization screenshot: #{json.data.link}"

    unless rect
        throw new Error "Cannot find application on screenshot; check '#{opts.path}' file"
    rects[opts.clientUid] = rect
    return

server.onScreenshot (opts) ->
    if exports.verbose
        log.log "🎞  Take screenshot"

    path = pathUtils.parse opts.expected
    opts.name ?= path.name
    opts.path = getPathWithBasename pathUtils.join(DEST, path.base), path.name
    opts.diff = getPathWithBasename opts.path, "#{path.name}_diff"
    opts.rect = rects[opts.clientUid]

    unless opts.rect
        throw new Error "Screenshots are not initialized"

    if tryTakeScreenshot(opts, testScreenshot)
        fs.unlinkSync opts.diff
        fs.unlinkSync opts.path
    else
        expectedCopyPath = getPathWithBasename opts.path, "#{path.name}_expected"
        try fs.copySync opts.expected, expectedCopyPath
        throw getScreenshotError opts
    return