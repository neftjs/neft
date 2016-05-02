'use strict'

cp = require 'child_process'

module.exports = (options) ->
    cp.execSync 'open build/ios/Neft.xcodeproj'
