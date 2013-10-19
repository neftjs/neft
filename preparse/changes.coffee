'use strict'

class Changes

	constructor: ->

		@arr = []
		@_tick = [null, null, null]
		@_tmp = []

	arr: null
	_index: 0
	_tick: null
	_tmp: []

	next: ->

		{arr, _index, _tick, _tmp} = @

		unless arr[_index] then return null

		_tmp[_index] = _tick[0] = arr[_index++]
		_tmp[_index] = _tick[1] = arr[_index++]
		_tmp[_index] = _tick[2] = arr[_index++]

		@_index = _index
		_tick

	prev: ->

		{_index, _tick, _tmp} = @

		if _index < 3 then return null

		_tick[2] = _tmp[--_index]
		_tick[1] = _tmp[--_index]
		_tick[0] = _tmp[--_index]

		@_index = _index
		_tick

	reset: ->

		@_index = 0

###
Return one-deep array with structure [node, placedunit, declaration, ...]
where declaration` is a DOM Node which replace `placedunit` in `node`.
###
module.exports = (target) ->

	{declarations, placedunits, contents} = target

	changes = new Changes
	arr = changes.arr

	# placedunits
	for placedunit in placedunits

		declaration = declarations[placedunit.nodeName]
		node = placedunit.parentNode

		arr.push node, placedunit, declaration

	# contents
	#changes.push.apply changes, contents

	changes