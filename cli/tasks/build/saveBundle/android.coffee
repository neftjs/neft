'use strict'

fs = require 'fs-extra'
cp = require 'child_process'

{utils, log} = Neft

ANDROID_BUNDLE_DIR = './build/android/'

module.exports = (options, callback) ->
    fs.copySync "#{ANDROID_BUNDLE_DIR}app/build/outputs/apk", options.out
    callback()
