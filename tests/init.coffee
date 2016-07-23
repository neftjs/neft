if process.argv.indexOf('--coverage') >= 0
    require 'coffee-coverage/register-istanbul'
else
    require('lib/moduleCache').registerFilenameResolver()
    require('lib/moduleCache').registerCoffeeScript()
global.Neft = require '../index'
global.Neft.unit = require 'lib/unit'
