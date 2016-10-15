'use strict'

https = require 'https'
fs = require 'fs'

{log} = Neft
log = log.scope 'sauce http'

{SAUCE_USERNAME, SAUCE_ACCESS_KEY} = process.env

exports.sendFile = (path, destFilename, callback) ->
    log "send file #{destFilename}"
    req = https.request
        hostname: 'saucelabs.com'
        path: "/rest/v1/storage/#{SAUCE_USERNAME}/#{destFilename}?overwrite=true"
        method: 'POST'
        auth: "#{SAUCE_USERNAME}:#{SAUCE_ACCESS_KEY}"
        headers:
            'Content-Type': 'application/octet-stream'
    , (res) ->
        res.on 'data', (data) ->
            log data + ''
        res.on 'end', ->
            log "end with code #{res.statusCode}"
            if res.statusCode isnt 200
                return callback new Error "Unexpected HTTP response code #{res.statusCode}"
            callback null

    req.write fs.readFileSync path
    req.end()

    req.on 'error', (err) ->
        log.error err
        callback err

    return
