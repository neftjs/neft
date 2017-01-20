'use strict'

fs = require 'fs-extra'
childProcess = require 'child_process'
which = require 'which'
utils = require 'src/utils'
signal = require 'src/signal'
logger = require '../logger'
config = require '../cli/config'

{log} = Neft

USER_DATA_DIR = "tmp/chrome-#{utils.uid()}"

CHROME_PATHS = [
    'chromium',
    'google-chrome',
    'chromium-browser',
    '/Applications/Chromium.app/Contents/MacOS/Chromium',
    '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
]

CHROME_ARGS = [
    '--enable-logging=stderr',
    '--v=1',
    '--no-first-run',
    "--user-data-dir=#{USER_DATA_DIR}",
    '--no-sandbox', # TODO: run chrome on travis in sandbox mode
    '--window-position=0,0'
]

CHROME_LOG_RE = ///
    # declaration
    ^\[
        # pid, date, severity
        (?:[0-9A-Z/]*:){4}
        # type
        (.*?)
        \([0-9]*\)
    \]
    (?:.*)
    # content
    "(.*)"
    (?:.*)$
///

CHROME_CONSOLE_LOG_TYPE = 'CONSOLE'

###
Returns path to the Chrome or Chromium process available on the machine
###
getChromePath = (callback) ->
    utils.async.forEach CHROME_PATHS, (path, index, array, next) ->
        which path, (err, resolvedPath) ->
            if err
                next()
            else
                callback null, resolvedPath
    , ->
        callback new Error 'Cannot resolve Chrome path'

###
Returns JavaScript console logs from Chrome logs
###
getConsoleLogs = (stdout) ->
    lines = String(stdout).split '\n'
    logs = []
    for line in lines
        parsedLine = CHROME_LOG_RE.exec line
        unless parsedLine?
            continue
        [_, type, content] = parsedLine
        if type is CHROME_CONSOLE_LOG_TYPE
            logs.push content
    logs

###
Runs the given URI in Chrome
###
runOnPathWithUri = (env, uri, callback) ->
    args = utils.clone CHROME_ARGS
    args.push "--app=#{uri}"

    if env.width? and env.height?
        args.push "--window-size=#{env.width},#{env.height}"

    chrome = childProcess.spawn env.path, args, env: config.getProcessEnv()

    chrome.on 'exit', ->
        fs.removeSync USER_DATA_DIR
        callback()

    chrome.stderr.on 'data', (data) ->
        for logMsg in getConsoleLogs(data)
            onLog.emit logMsg
        return

    process.once 'SIGINT', ->
        chrome.kill()

    onLog: onLog = signal.create()
    kill: ->
        chrome?.kill()

runAndLog = (env, logsReader, callback) ->
    log.info "running #{env.path}"
    url = config.getBrowserHttpServerUrl()
    chromeProcess = runOnPathWithUri env, url, ->
        log.info "#{env.path} terminated"
        callback logsReader.error
    chromeProcess.onLog (msg) ->
        logsReader.log msg
        if logsReader.terminated
            chromeProcess.kill()

exports.getName = (env) ->
    {path} = env
    if path
        "Chrome #{env.path} tests"
    else
        "Chrome tests"

exports.run = (env, logsReader, callback) ->
    if env.path
        return runAndLog env, logsReader, callback
    getChromePath (err, path) ->
        if err
            return callback err
        env.path = path
        exports.run env, logsReader, callback
