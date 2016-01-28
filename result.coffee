'use strict'

fs = require 'fs-extra'
crypto = require 'crypto'
pathUtils = require 'path'
coffee = require 'coffee-script'

CACHE_DIRECTORY = __dirname + '/.tmp'
fs.ensureDirSync CACHE_DIRECTORY

{stringify} = JSON

IS_COFFEE_RE = ///\.(coffee|litcoffee|coffee.md)$///
IS_LITERATE_COFFEE_RE = ///\.(litcoffee|coffee.md)$///
STRING_FILES =
	'.pegjs': true
	'.txt': true

replaceStr = (str, oldStr, newStr) ->
	i = str.indexOf oldStr
	unless ~i then return str

	r = str.slice 0, i
	r += newStr
	r += str.slice i + oldStr.length

	r

getFile = (path) ->
	try
		file = fs.readFileSync path, 'utf-8'
	catch
		return

	# compile coffee-script files and cache it
	if IS_COFFEE_RE.test(path)
		digest = crypto.createHash('sha1').update(file, 'utf8').digest('hex')
		cache = pathUtils.join CACHE_DIRECTORY, "#{digest}.js"
		if fs.existsSync(cache)
			file = fs.readFileSync cache, 'utf-8'
		else
			isLiterate = IS_LITERATE_COFFEE_RE.test path
			file = coffee.compile file, bare: true, literate: isLiterate
			fs.writeFileSync cache, file, 'utf-8'

	if STRING_FILES[pathUtils.extname(path)]
		file = "module.exports = #{JSON.stringify(file)}"

	file

fileScope = """(function(){
	'use strict';

	// list of modules with empty objects
	var modules = {{declarations}};

	// used as `require`
	function getModule(paths, name){
		var path = paths[name];
		return (path in modules ? modules[path] :
		       (typeof Neft !== "undefined" && Neft[name]) ||
		       (typeof require === 'function' && require(name)) ||
		       (function(){throw new Error("Cannot find module '"+name+"'");}()));
	};

	// fill modules by their bodies
	{{init}}

	var result = modules["{{path}}"];

	if(typeof module !== 'undefined'){
		return module.exports = result;
	} else {
		return result;
	}
})();"""

moduleScope = """(function(){
	var module = {exports: modules["{{name}}"]};
	var require = getModule.bind(null, {{paths}});
	var exports = module.exports;

	{{file}}

	return module.exports;
})();"""

getDeclarations = (modules) ->
	r = {}

	for name in modules
		r[name] = {}

	r

getModulesInit = (opts) ->
	r = ''

	for name in opts.modules
		modulePaths = opts.paths[name] or {}

		path = name
		unless func = getFile path
			continue

		name = name.replace /\\/g, '\\\\'

		switch pathUtils.extname name
			when '.json'
				func = "module.exports = #{func};"

		module = moduleScope
		module = replaceStr module, '{{name}}', name
		module = replaceStr module, '{{paths}}', stringify modulePaths
		module = replaceStr module, '{{file}}', func

		r += "modules['#{name}'] = #{module}"

	r

module.exports = (opts) ->
	declarations = getDeclarations opts.modules
	init = getModulesInit opts

	r = fileScope
	r = replaceStr r, '{{path}}', opts.path
	r = replaceStr r, '{{declarations}}', stringify declarations
	r = replaceStr r, '{{init}}', init

	r
