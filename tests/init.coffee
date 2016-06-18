if process.argv.indexOf('--coverage') >= 0
    require 'coffee-coverage/register-istanbul'
global.Neft = require '../index'
global.Neft.unit = require 'lib/unit'
