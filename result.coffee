'use strict'

fs = require 'fs'
pathUtils = require 'path'
coffee = require 'coffee-script'

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
STRING_FILES =
	'.pegjs': true
	'.txt': true

getFile = (path) ->
	# console.log "Include file: #{path}"
	file = fs.readFileSync path, 'utf-8'

	if IS_COFFEE_RE.test path
		isLiterate = IS_LITERATE_COFFEE_RE.test path
		file = coffee.compile file, bare: true, literate: isLiterate

	if STRING_FILES[pathUtils.extname(path)]
		file = "module.exports = #{JSON.stringify(file)}"

	file

fileScope = """(function(){
	'use strict';

	// list of modules with empty objects
	var modules = {{declarations}};

	// global object
	var globalRequire = typeof require !== 'undefined' && require;
	var setImmediate = setTimeout;
	var global = Object.create(null, {
		setImmediate: {
			enumerable: true,
			get: function(){ return setImmediate; },
			set: function(val){ setImmediate = val; }
		}
	});

	// standard polyfills
	console.assert = console.assert.bind(console);

	// used as `require`
	function getModule(paths, name){
		return modules[paths[name]] ||
		       (typeof Neft !== "undefined" && Neft[name]) ||
		       (typeof globalRequire === 'function' && globalRequire(name)) ||
		       (function(){throw new Error("Cannot find module '"+name+"'");}());
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

	(function(){
		{{file}}
	}());

	return module.exports;
})();"""

getDeclarations = (modules) ->
	r = {}

	r[name] = {} for name in modules

	r

getModulesInit = (opts) ->
	r = ''

	for name in opts.modules
		modulePaths = opts.paths[name] or {}

		path = name
		func = getFile path

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
