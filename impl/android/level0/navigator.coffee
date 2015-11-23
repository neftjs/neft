'use strict'

module.exports = (impl) ->
	{bridge} = impl

	navigator = null

	bridge.listen bridge.inActions.NAVIGATOR_LANGUAGE, (reader) ->
		navigator._language = reader.getString()
		return

	bridge.listen bridge.inActions.NAVIGATOR_ONLINE, (reader) ->
		navigator.online = reader.getBoolean()
		return

	initNavigatorNamespace: ->
		navigator = this