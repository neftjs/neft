'use strict'

global.Neft = require 'cli/bundle/neft-node-develop'

builder = require './cli/builder'
httpServer = require './cli/httpServer'
chromeEnv = require './env/chrome'
logger = require './cli/logger'
screenshot = require './screenshot/server'
server = require './server'
targets = require './cli/targets'

{log} = Neft

reportAndExit = (err) ->
    logger.saveOutput()
    if err
        log.error 'All tests ended: FAILURE'
        process.exit 1
    else
        log.ok 'All tests ended: SUCCESS'
        process.exit 0

server.startServer()
builder.buildProjects targets.getTargetsToBuild(), (err) ->
    if err
        return reportAndExit err
    targets.runEnvs (err) ->
        httpServer.closeServer()
        reportAndExit err
