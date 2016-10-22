'use strict'

fs = require 'fs'
parser = require './resources/parser'

{utils, log} = Neft

IN_DIR = './static'

module.exports = (platform, app, callback) ->
    logtime = log.time 'Parse resources'

    unless fs.existsSync(IN_DIR)
        return callback()

    parser.parse IN_DIR, (err, data) ->
        if err
            return callback err
        app.resources = data
        log.end logtime
        callback null
