'use strict'

fs = require 'fs'
parser = require './resources/parser'

IN_DIR = './static'

module.exports = (platform, app, callback) ->
    unless fs.existsSync(IN_DIR)
        return callback()

    parser.parse IN_DIR, (err, data) ->
        if err
            return callback err
        app.resources = data
        callback null
