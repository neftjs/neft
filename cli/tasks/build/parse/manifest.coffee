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
        {width: 36, height: 36, out: 'mipmap-ldpi/ic_launcher.png'},
        {width: 48, height: 48, out: 'mipmap-mdpi/ic_launcher.png'},
        {width: 72, height: 72, out: 'mipmap-hdpi/ic_launcher.png'},
        {width: 96, height: 96, out: 'mipmap-xhdpi/ic_launcher.png'},
        {width: 144, height: 144, out: 'mipmap-xxhdpi/ic_launcher.png'},
        {width: 192, height: 192, out: 'mipmap-xxxhdpi/ic_launcher.png'},
    ],
    ios: [
        {width: 58, height: 58, out: "iphone-29@2x.png"},
        {width: 87, height: 87, out: "iphone-29@3x.png"},
        {width: 80, height: 80, out: "iphone-40@2x.png"},
        {width: 120, height: 120, out: "iphone-40@3x.png"},
        {width: 120, height: 120, out: "iphone-60@2x.png"},
        {width: 180, height: 180, out: "iphone-60@3x.png"},
        {width: 29, height: 29, out: "ipad-29.png"},
        {width: 58, height: 58, out: "ipad-29@2x.png"},
        {width: 40, height: 40, out: "ipad-40.png"},
        {width: 80, height: 80, out: "ipad-40@2x.png"},
        {width: 76, height: 76, out: "ipad-76.png"},
        {width: 152, height: 152, out: "ipad-76@2x.png"},
        {width: 167, height: 167, out: "ipad-83p5@2x.png"},
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
