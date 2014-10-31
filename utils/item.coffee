'use strict'

utils = require 'utils'

module.exports = (Renderer, Impl) ->
	createBindingSetter: (propName, setFunc) ->
		(val) ->
			if Array.isArray val
				Impl.setItemBinding.call @, propName, val
			else
				setFunc.call @, val

	setProperty: (item, key, val) ->
		if val? and typeof val is 'object' and key of item.constructor.prototype and not Array.isArray(val) and not(val instanceof Renderer.Item) 
			utils.mergeDeep item[key], val
		else
			item[key] = val