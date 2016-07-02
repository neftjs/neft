# coffeelint: disable=no_debugger

'use strict'

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

exports.connect = (callback) ->
    sauceConnectLauncher
        username: SAUCE_USERNAME
        accessKey: SAUCE_ACCESS_KEY
        verbose: true
        tunnelIdentifier: TRAVIS_JOB_NUMBER
    , callback

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
