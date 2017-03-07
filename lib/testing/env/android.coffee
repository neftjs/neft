'use strict'

fs = require 'fs'
childProcess = require 'child_process'
pathUtils = require 'path'
builder = require '../cli/builder'
androidRun = require 'cli/tasks/run/android'

{utils, log} = Neft

ADB = 'platform-tools/adb'
EMULATOR = 'tools/emulator'
ANDROID = 'tools/android'
DEVICE_RUN_TRY_DELAY = 1000
DEFAULT_PORT = 5554
SDK_DIR = ''

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

getFreeDevicePort = ->
    numbers = getRunDeviceSerialNumbers()
    numbers = utils.arrayToObject numbers, ((i, elem) -> elem), -> true
    port = DEFAULT_PORT
    while numbers[port]
        port += 2 # emulator uses even numbers for console and odd as adb ports
    port

getEmulatorName = (env) ->
    name = "neft-#{env.target}-#{env.abi}-#{env.width}x#{env.height}"
    name = name.replace /[^a-zA-Z0-9._\-]/g, '_'
    name

isDeviceAvailable = (deviceSerialNumber) ->
    cmd = "#{ADB} -s #{deviceSerialNumber} shell service check mount"
    output = try childProcess.execSync cmd, cwd: SDK_DIR, stdio: 'pipe'
    utils.has String(output), ': found'

createEmulator = (env, logsReader, callback) ->
    name = getEmulatorName env
    env.emulatorName = name

    logsReader.log "Checking available android emulators"
    avds = childProcess.execSync "#{EMULATOR} -list-avds", cwd: SDK_DIR
    avds = String(avds).split '\n'
    if utils.has(avds, name)
        return callback null

    logsReader.log "Creating android emulator"
    cmd = "echo no | #{ANDROID} create avd --force -n #{name} "
    cmd += "-t #{env.target} --abi #{env.abi} --skin #{env.width}x#{env.height}"
    androidProcess = childProcess.exec cmd, cwd: SDK_DIR, (err, stdout, stderr) ->
        if err
            log.error err
            log.error childProcess.execSync "#{ANDROID} list targets", cwd: SDK_DIR

        callback err
    androidProcess.stdout.pipe process.stdout
    return

runEmulator = (env, logsReader, callback) ->
    logsReader.log "Checking run android devices"
    getDeviceSerialNumberByName env.emulatorName, (serialNumber) ->
        if serialNumber
            env.deviceSerialNumber = serialNumber
            callback null
            return

        logsReader.log "Starting android emulator"
        port = getFreeDevicePort()
        env.deviceSerialNumber = "emulator-#{port}"
        cmd = EMULATOR
        cmd += " -port #{port}"
        cmd += " -avd #{env.emulatorName}"
        emulatorProcess = childProcess.exec cmd, cwd: SDK_DIR
        emulatorProcess.stdout.pipe process.stdout

        callbackCalled = false
        emulatorProcess.stdout.on 'data', ->
            unless callbackCalled
                callbackCalled = true
                callback null
    return

runTests = (env, logsReader, callback, delay = 0) ->
    unless isDeviceAvailable(env.deviceSerialNumber)
        if delay is 0
            logsReader.log "Waiting for device"
        else if delay % (DEVICE_RUN_TRY_DELAY * 10) is 0
            logsReader.log "Waiting for device (#{delay / 1000}s)"
        setTimeout ->
            runTests env, logsReader, callback, delay + DEVICE_RUN_TRY_DELAY
        , DEVICE_RUN_TRY_DELAY
        return

    logsReader.log "Running android tests on #{env.deviceSerialNumber}"
    createdSerialNumbersByName[env.emulatorName] = env.deviceSerialNumber
    androidRun
        release: false
        deviceSerialNumber: env.deviceSerialNumber
        pipeOutput: false
        onLog: (msg) ->
            logsReader.log msg
            if logsReader.terminated
                callback logsReader.error
    , (err) ->
        callback err
    return

exports.takeScreenshot = ({env, path}) ->
    name = getEmulatorName env
    serialNumber = createdSerialNumbersByName[name]
    adbPath = "#{pathUtils.join(SDK_DIR, ADB)} -s #{serialNumber}"
    try childProcess.execSync "#{adbPath} shell mount -o rw,remount rootfs /", stdio: 'pipe'
    childProcess.execSync "#{adbPath} shell screencap -p /sdcard/screen.png", stdio: 'pipe'
    childProcess.execSync "#{adbPath} pull /sdcard/screen.png", stdio: 'pipe'
    fs.renameSync './screen.png', path
    return

exports.getName = (env) ->
    "#{utils.capitalize env.target} on #{env.abi} tests"

exports.run = (env, logsReader, callback) ->
    loadConfig()
    createEmulator env, logsReader, (err) ->
        if err
            return callback err
        runEmulator env, logsReader, (err, emulator) ->
            if err
                return callback err
            runTests env, logsReader, (err) ->
                callback err
