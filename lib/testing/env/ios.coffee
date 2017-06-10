'use strict'

childProcess = require 'child_process'
fs = require 'fs'
pathUtils = require 'path'

SIMULATOR_PATH = """
    /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/Contents/MacOS/Simulator
"""
PACKAGE_NAME = 'io.neft.tests'
PROJECT_CWD = './build/ios'
LOG_RE = /^[A-Za-z]+\s+[0-9]+\s+[0-9:]+\s+[^ ]+\s+Neft\[[0-9]+\]:\s\[([A-Z]+)\]\s(.+)$/gm
REALPATH = fs.realpathSync '.'

getDeviceId = (env) ->
    list = String childProcess.execSync 'xcrun simctl list devices'
    iosMatch = false
    deviceRe = new RegExp "^\\s*#{env.device}\\s\\((.+)\\)\\s\\((.+)\\)$"
    for line in list.split('\n')
        if line.startsWith("-- iOS #{env.ios}")
            iosMatch = true
        else if line.startsWith('--')
            iosMatch = false
        else if deviceRe.test(line)
            [_, id, status] = deviceRe.exec line
            return id: id, status: status
    throw new Error """
        Cannot resolve osx=#{env.osx} device=#{env.device};
        available devices:
        #{list}
    """

runSimulator = (env) ->
    cmd = "#{SIMULATOR_PATH} -CurrentDeviceUDID #{env.deviceId}"
    childProcess.exec cmd, stdio: 'pipe'

buildProject = (env) ->
    cmd = """
        xcodebuild \
        -workspace Neft.xcodeproj/project.xcworkspace \
        -scheme Neft \
        -destination 'platform=iOS Simulator,name=#{env.device},OS=#{env.ios}' \
        -configuration Debug \
        -derivedDataPath \
        build
    """
    childProcess.execSync cmd, cwd: PROJECT_CWD

installProject = (env) ->
    cmd = """
        xcrun simctl install #{env.deviceId} ./build/Build/Products/Debug-iphonesimulator/Neft.app
    """
    childProcess.execSync cmd, cwd: PROJECT_CWD, stdio: 'pipe'

launchProject = (env) ->
    cmd = """
        xcrun simctl launch #{env.deviceId} #{PACKAGE_NAME}
    """
    childProcess.execSync cmd, stdio: 'pipe'

getLogsPath = (env) ->
    pathUtils.join process.env.HOME, "Library/Logs/CoreSimulator/#{env.deviceId}/system.log"

clearLogs = (env) ->
    fs.unlinkSync getLogsPath env

tailLogs = (env, onLog, onExit) ->
    cmd = 'tail'
    args = ['-f', getLogsPath env]
    tail = childProcess.spawn cmd, args
    tail.stdout.on 'data', (data) ->
        LOG_RE.lastIndex = 0
        dataStr = String data
        while match = LOG_RE.exec(dataStr)
            [_, level, msg] = match
            onLog msg
        return

    tail.on 'exit', -> onExit()

    kill: ->
        tail.kill()

scanProgress = (env, logsReader, callback) ->
    onLog = (msg) ->
        logsReader.log msg
        if logsReader.terminated
            tail.kill()

    onExit = ->
        callback logsReader.error

    tail = tailLogs env, onLog, onExit
    return

exports.getName = (env) ->
    "#{env.device} on iOS #{env.ios} tests"

exports.TAKE_SCREENSHOT_DELAY_MS = 20000

exports.takeScreenshot = ({env, path}) ->
    deviceId = getDeviceId(env).id
    path = pathUtils.join REALPATH, path
    cmd = "xcrun simctl io #{deviceId} screenshot #{path}"
    childProcess.execSync cmd, stdio: 'pipe'

exports.run = (env, logsReader, callback) ->
    logsReader.log "Finding requested device id"
    device = getDeviceId env
    env.deviceId = device.id
    logsReader.log "Resolved device id is equal #{env.deviceId}"

    if device.status is 'Booted'
        logsReader.log "Requested simulator is already booted"
    else
        logsReader.log "Running simulator"
        runSimulator env

    logsReader.log "Building project"
    buildProject env

    logsReader.log "Installing project"
    installProject env

    logsReader.log "Running tests"
    clearLogs env
    launchProject env
    scanProgress env, logsReader, callback
    return
