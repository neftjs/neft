'use strict'

cp = require 'child_process'

module.exports = (options) ->
    cp.execSync 'open build/macos/io.neft.mac.xcodeproj'
