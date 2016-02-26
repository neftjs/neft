'use strict'

Module = require 'module'

# use 'neft' catalog for modules lookup
Module._load = do (_super = Module._load) -> (req, parent) ->
	if req?[0] is '.' or parent.filename.indexOf('node_modules') isnt -1
		return _super.call @, req, parent
	try
		_super.call @, "#{__dirname}/#{req}", parent
	catch err
		_super.call @, req, parent

# link modules
MODULES = ['utils', 'signal', 'Dict', 'List', 'log', 'Resources', 'native',
           'Renderer', 'Networking', 'Schema', 'Document', 'Styles', 'assert', 'db']
for name in MODULES
	exports[name] = exports[name.toLowerCase()] = require name.toLowerCase()
