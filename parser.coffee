'use strict'

fs = require 'fs'
PEG = require 'pegjs'
pegimport = require 'pegjs-import'

grammar = fs.readFileSync './grammar.pegjs', 'utf-8'

parser = pegimport.buildParser './grammar.pegjs',
	optimize: 'speed'

module.exports = (file) ->
	try
		parser.parse file
	catch err
		lines = file.split '\n'
		line = err.line - 1
		console.log lines[line-1] if err.line > 1
		console.log "\u001b[31m#{lines[line]}\u001b[39m" if line isnt lines.length
		console.log lines[line+1] if line < lines.length

		message = err.message.replace ///_1///g, ''
		console.log "\nLine #{err.line}, column #{err.column}: #{message}"
		process.exit()