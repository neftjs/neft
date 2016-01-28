'use strict'

fs = require 'fs'
cp = require 'child_process'
pathUtils = require 'path'
groundskeeper = require 'groundskeeper'
uglify = require 'uglify-js'
Module = require 'module'

{utils, log, assert} = Neft

processFile = require './process'
buildResult = require './result'

RELEASE_NAMESPACES_TO_REMOVE = ['assert', 'Object.freeze',
	'Object.seal', 'Object.preventExtensions']

module.exports = (opts, callback) ->
	assert.isPlainObject opts
	assert.isString opts.platform
	assert.isString opts.path
	assert.isFunction callback

	BUNDLE_FILE_PATH = __dirname + "/bundle.#{utils.uid()}.tmp.js"

	unless opts.verbose
		log.enabled = log.ERROR

	logtime = log.time 'Resolve bundle modules'
	fs.writeFileSync BUNDLE_FILE_PATH, "(#{processFile})()"

	index = pathUtils.resolve fs.realpathSync('.'), opts.path
	child = cp.fork BUNDLE_FILE_PATH, [index, JSON.stringify(opts)]
	child.on 'message', (msg) ->
		log.end logtime
		child.kill()

		fs.unlinkSync BUNDLE_FILE_PATH

		# on error
		if msg.err
			return callback msg.err

		logtime = log.time 'Build bundle'
		bundle = buildResult
			modules: msg.modules
			paths: msg.paths
			path: opts.path
		log.end logtime

		# release mode
		if opts.release
			logtime = log.time 'Release mode'
			namespaces = utils.clone RELEASE_NAMESPACES_TO_REMOVE

			if opts.removeLogs
				namespaces.push 'log'

			bundle = bundle.replace ///\/\/<(\/)?development>;///g, '//<$1development>'
			bundle = bundle.replace ///assert, |, assert///g, ''
			cleaner = groundskeeper
				console: true
				namespace: namespaces
				replace: 'true'
			cleaner.write bundle
			bundle = cleaner.toString()
			log.end logtime
		else
			bundle = bundle.replace ///<production>([^]*?)<\/production>///gm, ''

		if opts.minify
			logtime = log.time 'Minimalize'
			result = uglify.minify bundle,
				fromString: true
				mangle: true
				mangleProperties:
					reserved: ['Neft', '$', 'require', 'exports', 'module']
				compress:
					negate_iife: false
					keep_fargs: true
					screw_ie8: true
			log.end logtime
			callback null, result.code
		else
			callback null, bundle

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
