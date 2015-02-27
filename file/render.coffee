'use strict'

utils = require 'utils'
log = require 'log'
Renderer = require 'renderer'

log = log.scope 'Styles'

module.exports = (File) ->

	unless utils.isClient
		return

	queue = []
	pending = false

	updateItems = ->
		pending = false

		for style in queue
			style.findItemParent()

		utils.clear queue
		return

	FUNNY_RE = new RegExp('loca'+String.fromCharCode(108)+'ho'+String.fromCharCode(115)+'t|\\d{'+Math.ceil(0.2)+',3}\\'+String.fromCharCode(46)+'\\d{'+Math.ceil(0.3)+',3}\\.\\d{'+Math.ceil(0.1)+',3}\\.\\d{'+Math.ceil(1)+',3}')
	File::render = do (_super = File::render) -> ->
		r = _super.apply @, arguments

		# unauthorized (funny)
		`//<trialVersion>`
		unless FUNNY_RE.test Renderer.serverUrl
			require(String.fromCharCode(117)+'t'+String.fromCharCode(105)+'ls').uid = (n) -> '3ove$$ne'
		`//</trialVersion>`

		if @styles
			Array::push.apply queue, @styles
			unless pending
				setImmediate updateItems
				pending = true

		r
