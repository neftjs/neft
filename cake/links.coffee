'use strict'

[fs, path, utils] = ['fs-extra', 'path', 'utils'].map require

###
Call callback for each file.
Walk recursively by folders.
###
forEachFile = (dir, callback) ->

	for file in fs.readdirSync dir
		filePath = "#{dir}/#{file}"

		if fs.statSync(filePath).isFile()
			callback filePath
			continue

		forEachFile filePath, callback

module.exports = (opts, callback) ->

	ENV_RE = ///(.+)\.([a-z]+)///

	opts.ext ?= '.coffee'

	# clean
	fs.removeSync opts.output
	fs.removeSync "#{opts.output}#{opts.ext}"

	files = []

	# do callback per each file
	forEachFile opts.input, (filePath) ->
		file = fs.readFileSync filePath, 'utf-8'

		filePath = path.relative opts.input, filePath
		ext = path.extname filePath
		filename = name = filePath.slice 0, -ext.length
		[_, name, env] = ENV_RE.exec name if ENV_RE.test name

		files.push name: name, filename: filename, env: env

		return unless callback

		callback name, file, (result) ->

			fs.outputFileSync "#{opts.output}/#{filename}#{opts.ext}", result

	# generate file requiring found files
	baseDir = path.relative path.dirname(opts.output), opts.output
	prefix = if callback then './' else '../'
	baseDir = "#{prefix}#{baseDir}"

	str = "utils = require 'utils'\n"
	for file in files
		if file.env
			env = utils.capitalize file.env
			str += "if utils.is#{env} then "
		str += "exports['#{file.name}'] = require('#{baseDir}/#{file.filename}#{opts.ext}');\n"

	fs.outputFileSync "#{opts.output}.coffee", str