'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
Module = require 'module'
cp = require 'child_process'
os = require 'os'

{utils, log, assert} = Neft

release = require './release'
minify = require './minify'
bundle = require './bundle'

isWin32 = os.platform() is 'win32'

module.exports = (opts, callback) ->
	assert.isPlainObject opts
	assert.isString opts.platform
	assert.isString opts.path
	assert.isFunction callback

	unless opts.verbose
		log.enabled = log.ERROR

	logtime = log.time 'Resolve bundle modules'

	# stringify opts into JSON
	processOpts = JSON.stringify opts, (key, val) ->
		if typeof val is 'function'
			{_function: val+''}
		else
			val

	# run process file
	running = true
	processPath = pathUtils.join __dirname, './process.coffee'
	cmd = if isWin32 then 'coffee.cmd' else 'coffee'
	childProcess = cp.spawn cmd, [processPath, processOpts], stdio: ['ipc']

	if opts.logProcessStdout
		childProcess.stdout.on 'data', (data) ->
			console.log data+''

	stderr = ''
	childProcess.stderr.on 'data', (data) ->
		stderr += data

	childProcess.on 'exit', ->
		if running
			running = false
			log.end logtime
			return callback stderr or 'Internal error; no message has been sent'

	childProcess.on 'message', (result) ->
		running = false
		childProcess.kill()
		log.end logtime
		processData = JSON.parse result
		stack = new utils.async.Stack

		stack.add bundle, null, [processData, opts]
		stack.add release, null, [undefined, opts]
		stack.add minify, null, [undefined, opts]

		stack.runAll callback

# support for custom objects used to lookup for modules
moduleNamespaces = []
Module._load = do (_super = Module._load) -> (req, parent) ->
	for obj in moduleNamespaces
		if obj[req]
			return obj[req]
	_super.apply @, arguments

module.exports.addModulesNamespace = (obj) ->
	moduleNamespaces.push obj
	return

module.exports.removeModulesNamespace = (obj) ->
	index = moduleNamespaces.indexOf obj
	if index isnt -1
		moduleNamespaces.splice index, 1
	return
