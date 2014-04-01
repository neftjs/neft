'use strict'

[path] = ['path'].map require

modules = []
paths = {}

Module = module.constructor

# FIXME
utils = require 'utils'
utils.isNode = false
utils.isBrowser = true
global.window = {}

Module._load = do (_super = Module._load) -> (req, parent) ->

	r = _super.apply @, arguments

	filename = Module._resolveFilename req, parent

	modulePath = path.relative base, filename
	parentPath = path.relative base, parent.id
	unless parentPath then return r	

	modules.push modulePath unless ~modules.indexOf modulePath

	mpaths = paths[parentPath] ?= {}
	mpaths[req] = modulePath

	r

index = process.argv[2]
base = path.dirname index

try
	require index
catch err
	return process.send err: err.stack

# add index file into modules list
modules.push Object.keys(paths)[0]

process.send
	modules: modules
	paths: paths