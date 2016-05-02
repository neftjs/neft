'use strict'

module.exports = (impl) ->
	{bridge} = impl
	{outActions, pushAction, pushItem, pushBoolean, pushInteger, pushFloat, pushString} = bridge

	bridge.listen bridge.inActions.FONT_LOAD, (reader) ->
		source = reader.getString()
		success = reader.getBoolean()
		return

	loadFont: (name, source, sources) ->
		pushAction outActions.LOAD_FONT
		pushString name
		pushString source
		return