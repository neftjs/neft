'use strict'

sauceConnectLauncher = require 'sauce-connect-launcher'

{log} = Neft
log = log.scope 'sauce'

RECONNECTS = 15
RECONNECT_TIMEOUT = 1000 * 60 # 1 min

{TRAVIS_JOB_NUMBER, SAUCE_USERNAME, SAUCE_ACCESS_KEY} = process.env

sauceProcess = null
onSauceConnected = []
isConnecting = false
connectToProcess = ->
    if isConnecting
        return
    isConnecting = true
    tries = 0
    connectSauce = ->
        log 'connecting'
        sauceConnectLauncher
            username: SAUCE_USERNAME
            accessKey: SAUCE_ACCESS_KEY
            tunnelIdentifier: TRAVIS_JOB_NUMBER
        , (err, process) ->
            if err or not process
                if tries++ is RECONNECTS
                    throw new Error "Can't connect to SauceLabs; #{err}"
                log.warn """
                    can't connect to SauceLabs; next try (#{tries}) in #{RECONNECT_TIMEOUT}ms
                """
                setTimeout connectSauce, RECONNECT_TIMEOUT
                return
            log 'connected'
            sauceProcess = process
            while listener = onSauceConnected.pop()
                listener null, process
            return
    connectSauce()

exports.createConnection = do ->
    pendingConnections = 0

    class Connection
        constructor: ->
            pendingConnections += 1
            if pendingConnections is 1
                connectToProcess()
        close: ->
            pendingConnections -= 1
            if pendingConnections is 0
                sauceProcess?.close()
                if sauceProcess
                    isConnecting = false
                    sauceProcess = null

    ->
        new Connection

exports.getSauceProcess = (callback) ->
    if sauceProcess?
        callback null, sauceProcess
    else
        onSauceConnected.push callback
    return
