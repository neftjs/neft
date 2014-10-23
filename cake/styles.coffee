'use strict'

utils = require 'utils'

Renderer = require 'renderer'
pathUtils = require 'path'

scopes = {}

exports.compile = (file) ->

	data = file.data
	name = file.filename

	# prepare scope name
	parts = name.split '/'
	# parts.reverse()
	for part, i in parts
		parts[i] = part[0].toUpperCase() + part.slice(1)

	scopeItemName = parts.join ''
	scopeName = scopeItemName[0].toLowerCase() + scopeItemName.slice(1)

	scopes[scopeItemName] = name

	# bootstrap code
	base = parts.map(-> '../').join ''
	code = "'use strict'\n"
	code += "Renderer = require '../#{base}node_modules/app/node_modules/renderer'\n"
	code += "\n"

	# custom scope code
	code += "scope = new Renderer.Scope id: '#{scopeName}'\n"
	code += "{{modules}}\n"

	# scope types
	code += "{#{Object.keys(Renderer.Scope.TYPES)}} = scope\n"
	code += "\n"

	code += data

	# module exports
	code += '\n\nmodule.exports = scope.toItemCtor()\n'

	file.name = scopeItemName
	file.data = code

exports.finish = (file) ->
	data = file.data
	name = file.filename

	code = ''

	for scopeName, path of scopes
		if path isnt name and name.indexOf(path) is -1 and name.split('/').length <= path.split('/').length
			base = name.split('/')
			base.pop()

			localPath = path.split('/')[base.length...]

			localName = localPath.map (str) -> utils.capitalize(str)
			localName = localName.join ''

			base = name.split('/').map(-> '../').join('')
			base = base.slice 3
			base ||= './'
			code += "#{localName} = (args) -> scope.create require('#{base}#{path}'), args\n"
	code += "\n"

	data = data.replace '{{modules}}', code

	file.data = data