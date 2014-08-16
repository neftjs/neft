'use strict'

[path] = ['path'].map require

modules = []
paths = {}

# gets argv
[_, _, index, type] = process.argv

# Get index to require and their base path
base = path.dirname index

###
Override standard `Module._load()` to capture all required modules and files
###
Module = module.constructor
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

require "./process/#{type}"

# run index file
try
	require index
catch err
	if err.stack
		err = err.stack
	else
		err += ''
	return process.send err: err

# add index file into modules list
modules.push 'index.coffee'

process.send
	modules: modules
	paths: paths