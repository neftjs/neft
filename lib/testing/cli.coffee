'use strict'

global.Neft = require 'cli/bundle/neft-node-develop'

builder = require './cli/builder'
chromeEnv = require './env/chrome'
screenshot = require './screenshot/server'
server = require './server'
targets = require './cli/targets'
processLogs = require './cli/processLogs'

{log, utils} = Neft

PROCESS_EXIT_DELAY = 1000 # 1s

exitProcess = (code) ->
    setTimeout ->
        process.exit code
    , PROCESS_EXIT_DELAY

reportAndExit = (err) ->
    # log errors
    if not utils.isEmpty(processLogs.errors)
        log.log '''
            \n**Test errors**
            **-----------**
        '''
        for name, text of processLogs.errors
            log.log ''
            log.log "**✖ #{name}**"
            log.log text.replace /\n/g, '\n   '

    log.log '''
        \n**Test results**
        **------------**
    '''

    # log statistics
    log.log ''
    for name, stat of processLogs.stats
        log.log """
            **#{stat.passed}** #{name.toLowerCase()} passed; \
            **#{stat.passed + stat.failed}** total
        """

    # result
    log.log ''
    if err or not utils.isEmpty(processLogs.errors)
        if err
            log.error err
        log.error 'All tests ended: **FAILURE**'
        exitProcess 1
    else
        log.ok 'All tests ended: **SUCCESS**'
        exitProcess 0

module.exports = ({verbose}) ->
    processLogs.verbose = verbose
    screenshot.verbose = verbose
    server.startServer {verbose}
    targets.runEnvs (err) ->
        reportAndExit err
