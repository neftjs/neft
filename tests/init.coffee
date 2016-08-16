useCoverage = process.argv.indexOf('--coverage') >= 0

if useCoverage
    require 'coffee-coverage/register-istanbul'

moduleCache = require 'lib/module-cache'
unless useCoverage
    moduleCache.registerFilenameResolver()
    moduleCache.registerCoffeeScript()
moduleCache.registerYaml()
moduleCache.registerTxt(['.txt', '.pegjs'])

global.Neft = require '../index'
global.Neft.unit = require 'lib/unit'
