'use strict'

os = require 'os'
cp = require 'child_process'
pathUtils = require 'path'
fs = require 'fs-extra'

{utils, assert, unit} = Neft
{describe, it} = unit

isWin32 = os.platform() is 'win32'

NEFT_BIN_PATH = pathUtils.join(fs.realpathSync('./'), 'bin/neft')
EXEC_NEFT = if isWin32 then "#{NEFT_BIN_PATH}.cmd" else "sh #{NEFT_BIN_PATH}"

createApp = (callback) ->
	path = pathUtils.join os.tmpdir(), 'neft-project'
	fs.removeSync path

	cpCmd = "#{EXEC_NEFT} create #{path}"
	cp.exec cpCmd, callback
	path

describe 'CLI', ->
	describe 'neft create', ->
		it 'creates new project at the given path', (done) ->
			createApp (err, stdout, stderr) ->
				assert.match stdout, /Project created/
				done err or stderr

	describe 'neft build', ->
		describe 'node', ->
			it 'creates bundle', (done) ->
				path = createApp (err, _, stderr) ->
					cp.exec "cd #{path} && #{EXEC_NEFT} build node", (err, _, stderr) ->
						assert.ok fs.existsSync pathUtils.join(path, 'build/app-node-develop.js')
						done err or stderr

		describe 'browser', ->
			it 'creates bundle', (done) ->
				path = createApp (err, _, stderr) ->
					cp.exec "cd #{path} && #{EXEC_NEFT} build browser", (err, _, stderr) ->
						assert.ok fs.existsSync pathUtils.join(path, 'build/app-browser-develop.js')
						done err or stderr

	describe 'neft run', ->
		describe 'node', ->
			it 'starts node server', (done) ->
				path = createApp (err, _, stderr) ->
					child = cp.exec "cd #{path} && #{EXEC_NEFT} run node", (err, _, stderr) ->
						done err or stderr

					child.stdout.on 'data', (msg) ->
						if utils.has(msg, 'Start as')
							child.kill()
							setTimeout done
