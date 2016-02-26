'use strict'

exports = module.exports = require './app'

# link modules
MODULES = ['utils', 'signal', 'Dict', 'List', 'log', 'Resources', 'native',
           'Renderer', 'Networking', 'Schema', 'Document', 'Styles', 'assert', 'db']
for name in MODULES
	exports[name] = exports[name.toLowerCase()] = require name.toLowerCase()
