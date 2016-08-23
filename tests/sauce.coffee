# coffeelint: disable=no_debugger

'use strict'

tests = require './init'
unless tests.useSauce
    return

utils = require 'src/utils'
sauceConnectLauncher = require 'sauce-connect-launcher'
wd = require 'wd'
fs = require 'fs'
pathUtils = require 'path'
yaml = require 'js-yaml'
https = require 'https'

{TRAVIS_JOB_NUMBER, SAUCE_USERNAME, SAUCE_ACCESS_KEY} = process.env

SAUCE_HOST = 'ondemand.saucelabs.com'
SAUCE_PORT = 80
RECONNECTS = 10
RECONNECT_TIMEOUT = 5000

sauceProcess = null
onSauceConnected = []
do connectSauce = ->
    tries = 0
    sauceConnectLauncher
        username: SAUCE_USERNAME
        accessKey: SAUCE_ACCESS_KEY
        tunnelIdentifier: TRAVIS_JOB_NUMBER
    , (err, process) ->
        if err or not process
            if tries++ is RECONNECTS
                throw new Error "Can't connect to SauceLabs"
            setTimeout connectSauce, RECONNECT_TIMEOUT
        else
            sauceProcess = process
            for listener in onSauceConnected
                listener null, process
        return

process.on 'exit', ->
    sauceProcess?.close()

exports.connect = (callback) ->
    if sauceProcess?
        callback null, sauceProcess
    else
        onSauceConnected.push callback
    return

exports.getDriver = ->
    wd.remote(
        SAUCE_HOST, SAUCE_PORT,
        SAUCE_USERNAME, SAUCE_ACCESS_KEY
    )

exports.getPlatforms = (type) ->
    filename = fs.realpathSync pathUtils.join './tests/sauce/', "#{type}.yml"
    yaml.safeLoad fs.readFileSync filename, 'utf8'

exports.sendFile = (path, destFile, callback) ->
    console.log "HTTPS: Send file '#{path}' to Sauce storage as '#{destFile}'"

    req = https.request
        hostname: 'saucelabs.com'
        path: "/rest/v1/storage/#{SAUCE_USERNAME}/#{destFile}?overwrite=true"
        method: 'POST'
        auth: "#{SAUCE_USERNAME}:#{SAUCE_ACCESS_KEY}"
        headers:
            'Content-Type': 'application/octet-stream'
    , (res) ->
        res.on 'data', (data) ->
            console.log "HTTPS: Response #{data}"

        res.on 'end', ->
            {statusCode} = res
            console.log "HTTPS: Request finished with status #{statusCode}"
            if statusCode isnt 200
                err = new Error 'Unexpected HTTP response code'
            callback err

    req.write fs.readFileSync path
    req.end()

    req.on 'error', (err) ->
        console.log "HTTPS: ERROR #{err}"
        callback err

    return
