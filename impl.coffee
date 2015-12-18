'use strict'

utils = require 'utils'
assert = require 'assert'

# platform specified
PlatformImpl = switch true
	when utils.isNode
		require './impl/node/index'
	when utils.isBrowser
		require './impl/browser/index'
	when utils.isIOS
		require './impl/ios/index'
	when utils.isQt
		require './impl/qt/index'
	when utils.isAndroid
		require './impl/android/index'

assert PlatformImpl
, "No networking implementation found"

module.exports = (Networking) ->
	PlatformImpl Networking