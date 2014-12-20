'use strict'

grammar = '{{grammar}}'

module.exports = (file) ->
	fs = require 'fs'
	pathUtils = require 'path'
	PEG = require 'pegjs'

	parser = PEG.buildParser grammar,
		optimize: 'speed'

	try
		parser.parse(file)
	catch err
		lines = file.split '\n'
		line = err.line - 1
		msg = ''
		msg += lines[line-1] + "\n" if err.line > 1
		msg += "\u001b[31m#{lines[line]}\u001b[39m \n" if line isnt lines.length
		msg += lines[line+1] + "\n" if line < lines.length

		msg += "\nLine #{err.line}, column #{err.column}: #{err.message}\n"
		throw Error msg