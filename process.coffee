'use strict'

fs = require 'fs'
pathUtils = require 'path'
yaml = require 'js-yaml'
Module = require 'module'

# parse json opts from
opts = JSON.parse process.argv[2], (key, val) ->
	if val and val._function
		eval "(#{val._function})"
	else
		val

index = pathUtils.resolve fs.realpathSync('.'), opts.path
{platform, test, path} = opts
test ?= -> true

customGlobalProps = Object.create null
mockGlobal = (obj) ->
	for key, val of obj
		customGlobalProps[key] = global[key]
		global[key] = val
	return

base = pathUtils.dirname index

mockGlobal require("./emulators/#{platform}") opts

require.extensions['.pegjs'] = require.extensions['.txt'] = (module, filename) ->
	module.exports = fs.readFileSync filename, 'utf8'
require.extensions['.yaml'] = (module, filename) ->
	module.exports = yaml.safeLoad fs.readFileSync filename, 'utf8'

if opts.neftFilePath
	global.Neft = require opts.neftFilePath
	Neft.log.enabled = 0
else
	global.Neft = ->

modules = []
modulesByPaths = {}
paths = {}

# clear cache
for key of cache = Module._cache
	delete cache[key]

###
Override standard `Module._load()` to capture all required modules and files
###
disabled = false
Module = module.constructor
Module._load = do (_super = Module._load) -> (req, parent) ->
	if Neft[req]
		return Neft[req]

	disabledHere = false

	if not disabled and req isnt index and not test(req)
		disabled = true
		disabledHere = true
	r = _super.call @, req, parent
	if disabled
		if disabledHere
			disabled = false
		return r

	filename = Module._resolveFilename req, parent

	modulePath = pathUtils.relative base, filename
	parentPath = pathUtils.relative base, parent.id

	unless modulesByPaths[modulePath]
		modules.push modulePath
		modulesByPaths[modulePath] = true

	mpaths = paths[parentPath] ?= {}
	mpaths[req] = modulePath

	r

# run index file
try
	require index
catch err
	if err.stack
		err = err.stack
	else
		err += ''
	console.error err
	process.exit 1

resultJSON = JSON.stringify
	modules: modules
	paths: paths

process.send resultJSON
