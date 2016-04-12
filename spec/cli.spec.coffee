'use strict'

os = require 'os'
cp = require 'child_process'
pathUtils = require 'path'
fs = require 'fs-extra'

utils = require 'neft-utils'
assert = require 'neft-assert'
{describe, it} = require 'neft-unit'

createAndExec = (cmd='', callback) ->
	path = pathUtils.join os.tmpdir(), 'neft-project'
	fs.remove path

	neftBin = pathUtils.join fs.realpathSync(''), 'bin/neft'

	cpCmd = "NEFT_BIN=#{neftBin}; "
	cpCmd += "sh $NEFT_BIN create #{path}; "
	cpCmd += "cd #{path}; "
	cpCmd += cmd
	cp.exec cpCmd, callback

describe 'CLI', ->
	describe 'neft create', ->
		it 'creates new project at the given path', (done) ->
			createAndExec '', (err, stdout, stderr) ->
				assert.match stdout, /Project created/
				done err or stderr

	describe 'neft build', ->
		describe 'node', ->
			it 'creates bundle', (done) ->
				createAndExec 'sh $NEFT_BIN build node; rm ./build/app-node-develop.js', (err, stdout, stderr) ->
					done err or stderr
		describe 'browser', ->
			it 'creates bundle', (done) ->
				createAndExec 'sh $NEFT_BIN build browser; rm ./build/app-browser-develop.js', (err, stdout, stderr) ->
					done err or stderr

	describe 'neft run', ->
		describe 'node', ->
			it 'starts node server', (done) ->
				child = createAndExec 'sh $NEFT_BIN run node', (err, stdout, stderr) ->
					done err or stderr

				child.stdout.on 'data', (msg) ->
					if utils.has(msg, 'Start as')
						child.kill()
						setTimeout done
