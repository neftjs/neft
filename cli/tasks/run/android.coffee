'use strict'

fs = require 'fs'
open = require 'open'
cp = require 'child_process'

{log, utils} = Neft

FATAL_ERROR_DELAY = 2000

module.exports = (options, callback = ->) ->
    callbackCalled = false
    mode = if options.release then 'release' else 'develop'

    logtime = log.time 'Install APK'
    packageFile = JSON.parse fs.readFileSync('./package.json', 'utf-8')
    local = JSON.parse fs.readFileSync('./local.json', 'utf-8')

    {sdkDir} = local.android
    if sdkDir is '$ANDROID_HOME'
        sdkDir = process.env.ANDROID_HOME

    adbPath = "#{sdkDir}/platform-tools/adb"
    apkFileName = 'app-universal-debug.apk'

    if options.deviceSerialNumber
        adbPath += " -s #{options.deviceSerialNumber}"

    adb = logcat = null

    cmd = "#{adbPath} install -r build/android/app/build/outputs/apk/#{apkFileName}"
    adb = cp.exec cmd, (err) ->
        log.end logtime
        if err
            log.error err
            return

        # get current device time
        deviceTime = 0
        shellDate = cp.execSync "#{adbPath} shell date +%m-%d_%H:%M:%S"
        deviceTime = new Date(String(shellDate).replace('_', ' ')).valueOf()

        # run logcat
        LOG_RE = ///
            ^
            (\d+-\d+\s[0-9:.]+)\s
            ([A-Z])\/(?:Neft|AndroidRuntime)\s*
            \(\s*[0-9]+\):\s
            (.+)
            $
        ///gm
        LOG_LEVEL = /^(LOG|OK|INFO|WARN|ERROR):\s/
        logcat = do ->
            args = adbPath.split ' '
            args.push 'logcat', '-v', 'time', 'Neft:v', '*:E'
            cmd = args.shift()
            cp.spawn cmd, args
        logcat.stdout.on 'data', (data) ->
            LOG_RE.lastIndex = 0
            dataStr = String data
            while match = LOG_RE.exec(dataStr)
                [_, date, level, msg] = match
                if new Date(date).valueOf() <= deviceTime
                    continue
                if LOG_LEVEL.test(msg)
                    [levelStr, level] = LOG_LEVEL.exec msg
                    msg = msg.slice levelStr.length
                if utils.has(msg, 'FATAL EXCEPTION:')
                    setTimeout (msg) ->
                        logcat.kill()
                        unless callbackCalled
                            callbackCalled = true
                            callback msg
                    , FATAL_ERROR_DELAY, msg
                if options.onLog
                    options.onLog msg
                    continue
                switch level
                    when 'D', 'LOG'
                        log msg
                    when 'OK'
                        log.ok msg
                    when 'I', 'INFO'
                        log.info msg
                    when 'W', 'WARN'
                        log.warn msg
                    when 'E', 'F', 'ERROR'
                        log.error msg
                    else
                        log.error "Unknown log level", level, msg
            return

        # run app
        runCmd = """
            #{adbPath} shell am start \
            -a android.intent.action.MAIN \
            -n #{packageFile.android.package}/.MainActivity
        """
        shell = cp.exec runCmd, (err) ->
            if err
                logcat.kill()
                log.error err

    unless options.pipeOutput is false
        adb.stdout.pipe process.stdout
        adb.stderr.pipe process.stderr

    kill: ->
        if callbackCalled
            return
        callbackCalled = true
        adb.kill()
        logcat?.kill()
        callback()
