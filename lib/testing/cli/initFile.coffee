'use strict'

Neft.utils.merge global, require('lib/testing')
global.assert = Neft.assert

module.exports = (runApp) ->
    global.app = runApp()
    require 'build/tests'
