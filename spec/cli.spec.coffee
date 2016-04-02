'use strict'

os = require 'os'
cp = require 'child_process'
pathUtils = require 'path'
fs = require 'fs-extra'

utils = require 'neft-utils'
assert = require 'neft-assert'
{describe, it} = require 'neft-unit'

describe 'CLI', ->
	describe 'neft create', ->
		it 'creates new project at the given path', (done) ->
			path = pathUtils.join os.tmpdir(), 'neft-project'
			fs.remove path
			cp.exec "sh bin/neft create #{path}", (err, stdout, stderr) ->
				assert.match stdout, /Project created/
				done err or stderr
