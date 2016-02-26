'use strict'

fs = require 'fs'
open = require 'open'
cp = require 'child_process'

{log} = Neft

module.exports = (options) ->
	mode = if options.release then 'release' else 'develop'

	logtime = log.time 'Install APK'
	packageFile = JSON.parse fs.readFileSync('./package.json', 'utf-8')
	local = JSON.parse fs.readFileSync('./local.json', 'utf-8')

	{sdkDir} = local.android
	if sdkDir is '$ANDROID_HOME'
		sdkDir = (cp.execSync('echo $ANDROID_HOME')+'').trim()

	adbPath = "#{sdkDir}/platform-tools/adb"
	apkFileName = 'app-debug.apk'
	adb = cp.exec "#{adbPath} install -r build/android/app/build/outputs/apk/#{apkFileName}", (err) ->
		log.end logtime
		if err
			console.error err
			return

		# get current device time
		deviceTime = 0
		cp.exec "#{adbPath} shell date +%m-%d_%H:%M:%S", (err, data) ->
			deviceTime = new Date((data+'').replace('_', ' ')).valueOf()

		# run logcat
		LOG_RE = /^(\d+-\d+\s[0-9:.]+)\s([A-Z])\/Neft\s+\(\s*[0-9]+\):\s(.+)$/gm
		LOG_LEVEL = /^(LOG|OK|INFO|WARN|ERROR):\s/
		logcat = cp.spawn "#{adbPath}", ['logcat', '-v', 'time', 'Neft:v', '*:s']
		log.enabled = log.ALL
		logcat.stdout.on 'data', (data) ->
			while match = LOG_RE.exec(data+'')
				[_, date, level, msg] = match
				if new Date(date).valueOf() > deviceTime
					if LOG_LEVEL.test(msg)
						[levelStr, level] = LOG_LEVEL.exec msg
						msg = msg.slice levelStr.length
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
							console.error "Unknown log level", level, msg
			return

		# run app
		shell = cp.exec "#{adbPath} shell am start -a android.intent.action.MAIN -n #{packageFile.android.package}/.MainActivity", (err) ->
			if err
				logcat.kill()
				console.error err

	adb.stderr.on 'data', (data) ->
		console.log data+''
