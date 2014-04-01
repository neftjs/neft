'use strict'

[fs, coffee, path] = ['fs', 'coffee-script', 'path'].map require

{stringify} = JSON

replaceStr = (str, oldStr, newStr) ->

	i = str.indexOf oldStr
	unless ~i then return str

	r = str.slice 0, i
	r += newStr
	r += str.slice i + oldStr.length

	r

IS_COFFEE_RE = ///\.(coffee|litcoffee|coffee.md)$///
IS_LITERATE_COFFEE_RE = ///\.(litcoffee|coffee.md)$///
getFile = (path) ->

	file = fs.readFileSync path, 'utf-8'

	if IS_COFFEE_RE.test path
		isLiterate = IS_LITERATE_COFFEE_RE.test path
		file = coffee.compile file, bare: true, literate: isLiterate

	file

fileScope = ->

	'use strict'

	# list of modules with empty objects
	modules = '{{declarations}}';

	# standard polyfills
	setImmediate = setTimeout
	console.assert = console.assert.bind console

	# used as `require`
	getModule = (paths, name) ->

		modules[paths[name]]

	# fill modules by their bodies
	'{{init}}'

	null

moduleScope = ->

	module = exports: {}
	require = getModule.bind null, '{{paths}}'
	exports = module.exports

	do -> '{{file}}'; null

	module.exports

getDeclarations = (modules) ->

	r = {}

	r[name] = {} for name in modules

	r

getModulesInit = (modules, paths) ->

	r = ''

	for name in modules

		modulePaths = paths[name] or {}

		func = getFile name

		switch path.extname name
			when '.json'
				func = "module.exports = #{func};"

		module = autoCall moduleScope
		module = replaceStr module, '\'{{paths}}\'', stringify modulePaths
		module = replaceStr module, '\'{{file}}\';', func

		r += "modules['#{name}'] = #{module}"

	r

autoCall = (func) -> "(#{func})();"

module.exports = (modules, paths) ->

	declarations = getDeclarations modules
	init = getModulesInit modules, paths

	r = autoCall fileScope
	r = replaceStr r, '\'{{declarations}}\'', stringify declarations
	r = replaceStr r, '\'{{init}}\';', init

	r