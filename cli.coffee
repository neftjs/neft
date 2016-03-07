'use strict'

glob = require 'glob'
pathUtils = require 'path'
cp = require 'child_process'

[_, _, path] = process.argv

runTests = 0
testsCode = 0

runTestFile = (path) ->
	runTests += 1
	child = cp.fork path
	child.on 'exit', (code) ->
		testsCode ||= code
		if --runTests is 0
			process.exit testsCode

glob pathUtils.join(path, '/', '**/*.spec.*'), (err, files) ->
	if err
		throw err

	for file in files
		runTestFile file

	return
