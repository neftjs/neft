'use strict'

utils = require 'src/utils'
assert = require 'src/assert'

# platform specified
PlatformImpl = try require './impl/node/index'
PlatformImpl or= try require './impl/browser/index'
PlatformImpl or= try require './impl/ios/index'
PlatformImpl or= try require './impl/android/index'
PlatformImpl or= try require './impl/macos/index'

assert PlatformImpl
, "No networking implementation found"

module.exports = (Networking) ->
    PlatformImpl Networking
