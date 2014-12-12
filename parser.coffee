'use strict'

fs = require 'fs'
pathUtils = require 'path'
PEG = require 'pegjs'
pegimport = require 'pegjs-import'

path = pathUtils.join __dirname, './grammar.pegjs'
parser = pegimport.buildParser path,
	optimize: 'speed'

module.exports = (file) ->
	try
		parser.parse(file)
	catch err
		lines = file.split '\n'
		line = err.line - 1
		msg = ''
		msg += lines[line-1] + "\n" if err.line > 1
		msg += "\u001b[31m#{lines[line]}\u001b[39m \n" if line isnt lines.length
		msg += lines[line+1] + "\n" if line < lines.length

		message = err.message.replace ///_1///g, ''
		msg += "\nLine #{err.line}, column #{err.column}: #{message}\n"
		throw Error msg