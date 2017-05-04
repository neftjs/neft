'use strict'

global.Neft = require 'cli/bundle/neft-node-develop'

builder = require './cli/builder'
chromeEnv = require './env/chrome'
screenshot = require './screenshot/server'
server = require './server'
targets = require './cli/targets'
processLogs = require './cli/processLogs'

{log} = Neft

reportAndExit = (err) ->
    # log errors
    do ->
        for name, text of processLogs.errors
            log.error "\n✖ #{name}"
            log.error text.replace /\n/g, '\n   '

    # result
    if err
        log.error '\nAll tests ended: FAILURE\n'
        process.exit 1
    else
        # log statistics
        log ''
        for name, number of processLogs.passingTests
            log.ok "#{number} #{name.toLowerCase()} passing"

        log.ok '\nAll tests ended: SUCCESS\n'
        process.exit 0

server.startServer()
targets.runEnvs (err) ->
    reportAndExit err
