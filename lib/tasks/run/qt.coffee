'use strict'

log = require 'log'
fs = require 'fs'
pathUtils = require 'path'
cp = require 'child_process'

{log} = Neft

module.exports = (options) ->
	local = JSON.parse fs.readFileSync('./local.json', 'utf-8')
	qmlscene = pathUtils.join local.qt?.dir, '/bin/qmlscene'

	process = cp.spawn qmlscene, ['./build/qt/main.qml']

	LOG_RE = /^qml: (.+)$/gm
	LOG_LEVEL = /^(LOG|OK|INFO|WARN|ERROR):\s/
	process.stderr.on 'data', (data) ->
		if LOG_RE.test(data+'')
			LOG_RE.lastIndex = 0
			while match = LOG_RE.exec(data+'')
				[_, msg] = match
				if LOG_LEVEL.test(msg)
					[levelStr, level] = LOG_LEVEL.exec msg
					msg = msg.slice levelStr.length
				switch level
					when 'LOG'
						log msg
					when 'OK'
						log.ok msg
					when 'INFO'
						log.info msg
					when 'WARN'
						log.warn msg
					else
						log.error msg
		else
			log.error data

	process.stdout.on 'data', (data) ->
		log data