'use strict'

fs = require 'fs-extra'
pathUtils = require 'path'
Jimp = require 'jimp'
utils = require 'src/utils'
log = require 'src/log'

ICONS_DIR = './manifest/icons'
ICONS_OUT_DIR = './build/manifest/icons'

ICON_FORMATS = {
    android: [
    ],
    ios: [
    ]
}

resizeImage = (input, width, height, output, callback) ->
    Jimp.read input, (err, image) ->
        if err then return callback err
        image.resize(width, height).write output, callback

module.exports = (platform, app, callback) ->
    unless formats = ICON_FORMATS[platform]
        return callback()

    input = "#{ICONS_DIR}/#{platform}.png"
    unless fs.existsSync(input)
        input = "#{ICONS_DIR}/default.png"
        unless fs.existsSync(input)
            return callback()

    logLine = log.line().timer().loading "Generating icon files"

    stack = new utils.async.Stack

    for format in formats
        out = "#{ICONS_OUT_DIR}/#{platform}/#{format.out}"
        fs.ensureDirSync pathUtils.dirname(out)
        stack.add resizeImage, null, [input, format.width, format.height, out]

    stack.runAllSimultaneously (err) ->
        if err
            logLine.error "Cannot generate icons", err
        else
            logLine.ok "Icons generated"
        logLine.stop()
        callback err
