'use strict'

Neft.utils.merge global, require('lib/testing')
global.assert = Neft.assert

module.exports = (runApp) ->
    global.app = runApp()
    if app?
        global.environment = global.app.config.environment
    require 'build/tests'
