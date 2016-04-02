'use strict'

cp = require 'child_process'
{describe, it} = require 'neft-unit'

describe 'Neft modules', ->
	it 'pass unit tests', (done) ->
		cp.exec 'node ./node_modules/neft-unit/bin/unit.js \'./node_modules/neft-*/\'', (err, stdout, stderr) ->
			console.log stdout.replace /^/gm, '        '
			done err or stderr
