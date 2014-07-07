'use strict'

[fs, path, utils, expect] = ['fs-extra', 'path', 'utils', 'expect'].map require

###
Call callback for each file.
Walk recursively by folders.
###
forEachFile = (dir, callback) ->

	for file in fs.readdirSync dir
		filePath = "#{dir}/#{file}"

		stat = fs.statSync(filePath)
		if stat.isFile()
			callback filePath, stat
			continue

		forEachFile filePath, callback

module.exports = class LinksBuilder

	@ENV_RE = ///(.+)\.([a-z]+)///

	@build = (opts) ->
		builder = new LinksBuilder opts
		builder.run()
		builder

	constructor: (opts) ->

		expect(opts).toBe.simpleObject()
		expect().defined(opts.files).toBe.array()
		expect().defined(opts.ext).toBe.truthy().string()
		expect().defined(opts.input).toBe.truthy().string()
		expect().defined(opts.output).toBe.truthy().string()
		expect().defined(opts.onFile).toBe.function()

		utils.fill @, opts

		@files ?= []

	ext: '.coffee'
	input: ''
	output: ''
	onFile: null
	files: null

	cleanOutput: ->
		fs.removeSync @output
		fs.removeSync "#{@output}.coffee"

	findFiles: ->

		forEachFile @input, (filePath, stat) =>
			file = fs.readFileSync filePath, 'utf-8'

			filePath = path.relative @input, filePath
			ext = path.extname filePath
			filename = name = filePath.slice 0, -ext.length

			if LinksBuilder.ENV_RE.test name
				[_, name, env] = LinksBuilder.ENV_RE.exec name

			file = new LinksBuilder.File
				name: name
				filename: filename
				filepath: filePath
				env: env
				data: file

			return if @onFile?(file) is false

			@addFile file

	addFile: (file) ->

		expect(file).toBe.any LinksBuilder.File
		expect().some(@files).not().toBe.file

		@files.push file

	writeFile: (file) ->

		if file.env then file.filename += ".#{file.env}"

		file.saved = true
		fs.outputFileSync "#{@output}/#{file.filename}#{@ext}", file.data

	save: ->

		baseDir = path.relative path.dirname(@output), @output

		str = "utils = require 'utils'\n"
		for file in @files

			prefix = if file.saved then './' else '../'
			fileBaseDir = "#{prefix}#{baseDir}"

			if file.env
				env = utils.capitalize file.env
				str += "if utils.is#{env} then "

			str += "exports['#{file.name}'] = require('#{fileBaseDir}/#{file.filename}#{@ext}');\n"

		fs.outputFileSync "#{@output}.coffee", str

	run: ->

		@cleanOutput()
		@findFiles()
		@save()

module.exports.File = class File

	constructor: (opts) ->

		expect(opts).toBe.simpleObject()
		expect(opts.saved).toBe undefined
		expect(opts.name).toBe.truthy().string()
		expect().defined(opts.filename).toBe.truthy().string()
		expect().defined(opts.filepath).toBe.truthy().string()
		expect().defined(opts.env).toBe.truthy().string()
		expect(opts.data).toBe.truthy().string()

		utils.fill @, opts

		@filename = @name unless @filename
		@filepath = @name unless @filepath

	saved: false
	name: ''
	filename: ''
	filepath: ''
	env: ''
	data: ''