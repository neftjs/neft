'use strict'

utils = require 'utils'

Renderer = require 'renderer'
pathUtils = require 'path'
nmlParser = require './nml'

scopes = {}

AVAILABLE_MODULES =
	'Renderer': 'renderer'
	'Dict': 'dict'
	'List': 'list'
	'signal': 'signal'
	'log': 'log'
	'expect': 'expect'

exports.compile = (file) ->

	data = file.data
	name = file.filename

	# prepare scope name
	parts = name.split '/'
	for part, i in parts
		parts[i] = part[0].toUpperCase() + part.slice(1)

	scopeItemName = parts.join ''
	scopeName = scopeItemName[0].toLowerCase() + scopeItemName.slice(1)

	scopes[scopeItemName] = name

	# bootstrap code
	base = parts.map(-> '../').join ''
	code = "'use strict'\n"

	for name, path of AVAILABLE_MODULES
		code += "#{name} = require '../#{base}node_modules/app/node_modules/#{path}'\n"

	code += "\n"

	# point files tot require for the build system
	code += "{{modulesLinks}}\n"

	# scope types
	code += "{#{Object.keys(Renderer)}} = Renderer\n"
	code += "\n"

	# exports as a function
	code += "getStructure = ->\n"

	# window reference
	code += "	{window} = Renderer\n"

	# custom scope code
	code += "{{modules}}\n"

	# parse NML
	if pathUtils.extname(file.filepath) is '.nml'
		data = nmlParser data

	# data to the function
	code += data.replace ///^///gm, '	'

	# support using scope as element
	code += "\n	if arguments.length\n" +
	        "		mainItem.constructor.apply mainItem, arguments\n"

	# return data
	code += "\n"
	code += "	Object.freeze({\n" +
	        "		mainItem: mainItem\n" +
	        "		ids: ids\n" +
	        "	})\n"

	code += "module.exports = -> getStructure.apply(null, arguments).mainItem\n"
	code += "module.exports.withStructure = -> getStructure.apply null, arguments\n"

	file.name = scopeItemName
	file.data = code

exports.finish = (file) ->
	data = file.data
	name = file.filename

	code = '	items = {}\n'
	links = ''

	for scopeName, path of scopes
		# if path isnt name and name.indexOf(path) is -1 and name.split('/').length <= path.split('/').length
		if path isnt name
			base = name.split('/')
			base.pop()

			localPath = path.split '/'
			i = 0
			while localPath.length
				if localPath[0] is base[i] and localPath.length > 1
					localPath.shift()
					i++
				else
					break

			unless localPath.length
				continue
			# localPath = localPath.splice Math.min(base.length, localPath.length-1)

			localName = localPath.map (str) -> utils.capitalize(str)
			localName = localName.join ''

			base = name.split('/').map(-> '../').join('')
			base = base.slice 3
			base ||= './'
			links += "require '#{base}#{path}'\n"
			code += "	#{localName} = items['#{localName}'] = require('#{base}#{path}')\n"
	code += "\n"

	data = data.replace '{{modulesLinks}}', links
	data = data.replace '{{modules}}', code

	file.data = data