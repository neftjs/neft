'use strict'

cp = require 'child_process'
glob = require 'glob'
{describe, it} = require 'neft-unit'

describe 'Neft modules', ->
	it 'pass unit tests', (done) ->
		glob 'node_modules/neft-*', (err, files) ->
			if err
				return done err

			doneLength = 0
			doneCalled = false
			for file in files
				cp.exec "cd #{file} && npm test", (err, stdout, stderr) ->
					if doneCalled
						if stderr
							console.eror stderr
						return
					doneLength++
					if err
						done err or stderr
						doneCalled = true
					else if doneLength is files.length
						done()
			return
