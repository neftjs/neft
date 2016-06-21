# coffeelint: disable=no_debugger

'use strict'

sauceConnectLauncher = require 'sauce-connect-launcher'
wd = require 'wd'
fs = require 'fs'
pathUtils = require 'path'
yaml = require 'js-yaml'

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
