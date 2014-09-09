'use strict'

utils = require 'utils'

{assert} = console

# platform specified
PlatformImpl = switch true
	when utils.isNode
		require './impl/node/index'
	when utils.isBrowser
		require './impl/browser/index'
	when utils.isQML
		require './impl/qml/index'

assert PlatformImpl
, "No routing implementation found"

module.exports = (Routing) ->
	PlatformImpl Routing