'use strict'

fs = require 'fs'
pathUtils = require 'path'
glob = require 'glob'
{describe, it} = require 'neft-unit'

files = glob.sync './node_modules/neft-*/tests/**/*.coffee'
realpath = fs.realpathSync ''

for file in files
	require pathUtils.join(realpath, file)
