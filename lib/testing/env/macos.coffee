'use strict'

childProcess = require 'child_process'
fs = require 'fs'
pathUtils = require 'path'

{log} = Neft

PACKAGE_NAME = 'io.neft.tests'
PROJECT_CWD = './build/macos'
LOG_RE = /^.*io\.neft\.mac\[[0-9:]+\]\s\[([A-Z]+)\]\s(.+)$/gm
REALPATH = fs.realpathSync '.'

buildProject = (env) ->
    childProcess.execSync "xcodebuild", cwd: PROJECT_CWD

launchProject = (env, logsReader, callback) ->
    mainErr = null
    cmd = """
        build/Release/io.neft.mac.app/Contents/MacOS/io.neft.mac
    """
    appProcess = childProcess.exec cmd, cwd: PROJECT_CWD
    appProcess.stderr.on 'data', (data) ->
        LOG_RE.lastIndex = 0
        dataStr = String data
        while match = LOG_RE.exec(dataStr)
            [_, level, msg] = match
            logsReader.log msg
        if logsReader.terminated
            appProcess.kill()
    appProcess.on 'exit', ->
        unless logsReader.terminated
            mainErr ?= "MacOS tests terminated before all tests ended"
        callback mainErr

exports.getName = (env) ->
    "MacOS tests"

exports.focusWindow = ->
    cmd = '''
        osascript -e 'tell application "io.neft.mac"' -e 'activate' -e 'end tell'
    '''
    childProcess.execSync cmd
    return

exports.build = (env, callback) ->
    logLine = log.line().timer().info "Building MacOS project... (may take a while)"
    try
        buildProject env
    catch err
        logLine.error "Cannot build project"
        log.error String err.stdout
        return callback new Error "Cannot build MacOS project"
    logLine.ok "MacOS project built"
    callback()
    return

exports.run = (env, logsReader, callback) ->
    launchProject env, logsReader, callback
    return
