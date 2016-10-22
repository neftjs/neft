'use strict'

wd = require 'wd'

{utils, log} = Neft
log = log.scope 'selenium'

SAUCE_HOST = 'ondemand.saucelabs.com'
SAUCE_PORT = 80

{SAUCE_USERNAME, SAUCE_ACCESS_KEY} = process.env

class Driver
    constructor: (@driver) ->
        @stack = new utils.async.Stack

    run: (func, args, onResult = utils.NOP) ->
        @stack.add @driver[func], @driver, args
        @stack.add (result, callback) ->
            try
                onResult result
            catch err
                return callback err
            callback null

    wait: (delay) ->
        @stack.add (callback) ->
            setTimeout callback, delay

    fulfil: (callback) ->
        log 'run commands'
        @stack.runAll (err) =>
            log 'set sauce job status'
            @driver.sauceJobStatus not err, =>
                @driver.quit()
                callback err

exports.getDriver = ->
    new Driver wd.remote(
        SAUCE_HOST, SAUCE_PORT,
        SAUCE_USERNAME, SAUCE_ACCESS_KEY
    )
