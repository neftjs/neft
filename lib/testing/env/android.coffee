'use strict'

fs = require 'fs'
childProcess = require 'child_process'
pathUtils = require 'path'
builder = require '../cli/builder'
androidRun = require 'cli/tasks/run/android'

{utils, log} = Neft
log = log.scope('testing').scope 'android'

ADB = 'platform-tools/adb'
EMULATOR = 'tools/emulator'
AVDMANAGER = 'tools/bin/avdmanager'
DEVICE_RUN_TRY_DELAY = 1000
DEFAULT_PORT = 5554
SDK_DIR = ''
PORT_SERIAL_NUMBER_PREFIX = "emulator-"
CI = !!process.env.CI

loadConfig = ->
    SDK_DIR = do ->
        sdkDir = require(fs.realpathSync './local.json').android.sdkDir
        if sdkDir?[0] is '$'
            sdkDir = process.env[sdkDir.slice 1]
        sdkDir

getRunDeviceSerialNumbers = ->
    output = String childProcess.execSync "#{ADB} devices", cwd: SDK_DIR
    devices = []
    for line, i in output.split('\n')
        line = line.trim()
        if i is 0 or line[0] is '*'
            continue
        [_, device] = line.match(/(.+)\s/) or []
        if device
            devices.push device
    devices

getDeviceNameBySerialNumber = (serialNumber, callback) ->
    [_, port] = serialNumber.match(/([0-9]+)/) or []
    unless port
        return

    telnet = childProcess.spawn 'telnet', ['localhost', port]

    stdout = ''
    input = ['avd name\n', 'exit\n']
    telnet.stdout.on 'data', (data) ->
        stdout += data
        if utils.has(String(data), 'OK')
            telnet.stdin.write input.shift()

    telnet.on 'exit', ->
        [name] = stdout.match(/^neft-(.+)$/m) or []
        callback name

    return

createdSerialNumbersByName = Object.create null

getDeviceSerialNumberByName = do ->
    numbersByName = Object.create null
    namesByNumbers = Object.create null
    (name, callback) ->
        # get from cache
        if number = numbersByName[name]
            callback number
            return

        # get run devices numbers
        numbers = getRunDeviceSerialNumbers()
        loading = 0
        for number in numbers then do (number) ->
            if numbersByName[number]
                return
            loading += 1

            # get device name
            getDeviceNameBySerialNumber number, (deviceName) ->
                numbersByName[deviceName] = number
                namesByNumbers[number] = deviceName
                loading -= 1
                unless loading
                    callback numbersByName[name]

        unless loading
            callback null
        return

getDeviceSerialNumberForPort = (port) ->
    PORT_SERIAL_NUMBER_PREFIX + port

getFreeDevicePort = ->
    serialNumbers = getRunDeviceSerialNumbers()
    serialNumbers = utils.arrayToObject serialNumbers, ((i, elem) -> elem), -> true
    port = DEFAULT_PORT
    while serialNumbers[getDeviceSerialNumberForPort port]
        port += 2 # emulator uses even numbers for console and odd as adb ports
    port

getEmulatorName = (env) ->
    name = "neft-#{env.target}-#{env.abi}"
    name = name.replace /[^a-zA-Z0-9._\-]/g, '_'
    name

isDeviceAvailable = (deviceSerialNumber) ->
    cmd = "#{ADB} -s #{deviceSerialNumber} shell getprop sys.boot_completed"
    output = try childProcess.execSync cmd, cwd: SDK_DIR, stdio: 'pipe'
    String(output).trim() is '1'

createEmulator = (env, callback) ->
    name = getEmulatorName env
    env.emulatorName = name

    log.debug "Checking available android emulators"
    avds = childProcess.execSync "#{EMULATOR} -list-avds", cwd: SDK_DIR
    avds = String(avds).split '\n'
    if utils.has(avds, name)
        return callback null

    log.debug "Creating android emulator"
    cmd = "echo no | #{AVDMANAGER} create avd --force -n #{name} "
    cmd += "-k \"system-images;#{env.target};default;#{env.abi}\""
    log.debug "> #{cmd}" if CI
    androidProcess = childProcess.exec cmd, cwd: SDK_DIR, (err, stdout, stderr) ->
        if err
            log.error err
            log.error childProcess.execSync "#{AVDMANAGER} list target", cwd: SDK_DIR

        callback err
    androidProcess.stdout.pipe process.stdout
    return

runEmulator = (env, callback) ->
    log.debug "Checking run android devices"
    pending = true

    finishWhenReady = (delay = 0) ->
        unless pending
            return

        if isDeviceAvailable(env.deviceSerialNumber)
            pending = false
            callback null
            return

        if delay is 0
            log.debug "Waiting for device"
        else if delay % (DEVICE_RUN_TRY_DELAY * 10) is 0
            log.debug "Waiting for device (#{delay / 1000}s)"
        setTimeout ->
            finishWhenReady delay + DEVICE_RUN_TRY_DELAY
        , DEVICE_RUN_TRY_DELAY

    getDeviceSerialNumberByName env.emulatorName, (serialNumber) ->
        if serialNumber
            env.deviceSerialNumber = serialNumber
            finishWhenReady()
            return

        log.debug "Starting android emulator"
        port = getFreeDevicePort()
        env.deviceSerialNumber = getDeviceSerialNumberForPort port
        cmd = EMULATOR
        cmd += " -port #{port}"
        cmd += " -avd #{env.emulatorName}"
        cmd += " -skin #{env.width}x#{env.height}"
        log.debug "> #{cmd}" if CI
        emulatorProcess = childProcess.exec cmd, cwd: SDK_DIR, (err, stdout, stderr) ->
            if (err or stderr) and pending
                pending = false
                log.error err or stderr
                callback new Error 'Cannot run android emulator'
        emulatorProcess.stdout.pipe process.stdout
        finishWhenReady()
    return

closeProcessNotRespondingPopup = (deviceSerialNumber) ->
    # close any popup
    # in most cases on slow machines you will see prompt wait/ok
    # this command emulates ENTER key two times to focus CLOSE APP and click it
    childProcess.execSync """
        #{ADB} -s #{deviceSerialNumber} shell input keyevent 66 66 &
    """, cwd: SDK_DIR

runTests = (env, callback) ->
    log.debug "Running android tests on #{env.deviceSerialNumber}"
    createdSerialNumbersByName[env.emulatorName] = env.deviceSerialNumber
    androidProcess = androidRun
        release: false
        deviceSerialNumber: env.deviceSerialNumber
        pipeOutput: false
        onRun: callback
        onLog: (msg) ->
            env.onLog msg, androidProcess
    , (err) ->
        if env.onExit
            env.onExit err
        else
            callback err
    return

listenOnTests = (env, logsReader, callback) ->
    env.onExit = callback
    env.onLog = (msg, androidProcess) ->
        logsReader.log msg
        if logsReader.terminated
            androidProcess.kill()
        return

exports.onInitializeScreenshots = (env) ->
    name = getEmulatorName env
    deviceSerialNumber = createdSerialNumbersByName[name]
    closeProcessNotRespondingPopup deviceSerialNumber

# FIXME
# exports.takeScreenshot = ({env, path}) ->
#     name = getEmulatorName env
#     serialNumber = createdSerialNumbersByName[name]
#     adbPath = "#{pathUtils.join(SDK_DIR, ADB)} -s #{serialNumber}"
#     childProcess.execSync "
#         #{adbPath} shell screencap -p | \
#         perl -pe 's/\\x0D\\x0A/\\x0A/g' \
#         > screen.png
#     ", stdio: 'pipe'
#     fs.renameSync './screen.png', path
#     return

exports.getName = (env) ->
    "#{utils.capitalize env.target} on #{env.abi} tests"

exports.build = (env, callback) ->
    loadConfig()
    createEmulator env, (err) ->
        if err
            return callback err
        runEmulator env, (err) ->
            if err
                return callback err
            runTests env, callback

exports.run = (env, logsReader, callback) ->
    listenOnTests env, logsReader, callback
