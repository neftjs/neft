	'use strict'

	utils = require 'src/utils'

	NOP = ->

	PLATFORMS =
		onNode: 'isNode'
		onServer: 'isServer'
		onClient: 'isClient'
		onBrowser: 'isBrowser'
		onAndroid: 'isAndroid'
		onIOS: 'isIOS'

	exports.applyAll = (func) ->

isNode
--

isServer
--

isClient
--

isBrowser
--

isAndroid
--

isIOS
--

		for funcName, utilsProp of PLATFORMS
			func[funcName] = if utils[utilsProp] then -> this else NOP
		return
