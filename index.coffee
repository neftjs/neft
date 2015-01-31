'use strict'

fs = require 'fs'
assert = require 'neft-assert'
cp = require 'child_process'
pathUtils = require 'path'

processFile = require './process'
buildResult = require './result'

module.exports = (opts, callback) ->
	assert.isPlainObject opts
	assert.isString opts.type
	assert.isString opts.path
	assert.isFunction callback

	BUNDLE_FILE_PATH = __dirname + '/bundle.tmp.js'

	fs.writeFileSync BUNDLE_FILE_PATH, "(#{processFile})()"

	index = pathUtils.resolve fs.realpathSync('.'), opts.path
	child = cp.fork BUNDLE_FILE_PATH, [index, JSON.stringify(opts)]#, silent: true
	child.on 'message', (msg) ->
		child.kill()

		fs.unlinkSync BUNDLE_FILE_PATH

		# on error
		if msg.err
			return callback msg.err

		bundle = buildResult
			modules: msg.modules
			paths: msg.paths
			path: opts.path

		if opts.release
			groundskeeper = require 'groundskeeper'
			uglify = require 'uglify-js'

			bundle = bundle.replace ///\/\/<(\/)?development>;///g, '//<$1development>'
			bundle = bundle.replace ///expect, |, expect///g, ''
			bundle = bundle.replace ///assert, |, assert///g, ''
			cleaner = groundskeeper
				namespace: ['expect', 'assert', 'Object.freeze', 'Object.seal', 'Object.preventExtensions']
				replace: 'true'
			cleaner.write bundle
			bundle = cleaner.toString()

			fs.writeFileSync './tmp.js', bundle, 'utf-8'

			cp.exec "./node_modules/uglify-js/bin/uglifyjs " +
			"./tmp.js " +
			"--screw-ie8 " +
			"--compress negate_iife=false,keep_fargs " +
			"--mangle " +
			"--reserved 'Neft,$,require,exports' " +
			"--beautify",
				maxBuffer: 1024*1024
				, (err, stdout, stderr) ->
					fs.unlinkSync './tmp.js'

					# bundle = uglify.minify bundle,
					# 	fromString: true
					# 	warnings: true
					# 	mangle: false
					# 	beautify: true
					# bundle = bundle.code

					callback err, stdout
		else
			callback null, bundle

# if process.argv.length > 2
# 	[_, _, path, type] = process.argv

# 	onlyLocal = process.argv.join('').indexOf('--only-local') > 0
# 	release = process.argv.join('').indexOf('--release') > 0

# 	module.exports {path: path, type: type, onlyLocal: onlyLocal, release: release}, (err, result) ->
# 		fs.writeFileSync './out.js', result, 'utf-8'