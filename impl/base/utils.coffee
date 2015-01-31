utils = require 'utils'

exports.GETTER_METHODS_NAMES =
	'x': 'getItemX'
	'y': 'getItemY'
	'width': 'getItemWidth'
	'height': 'getItemHeight'

exports.SETTER_METHODS_NAMES =
	'x': 'setItemX'
	'y': 'setItemY'
	'width': 'setItemWidth'
	'height': 'setItemHeight'
	'opacity': 'setItemOpacity'

exports.grid = require './utils/grid'

exports.createDataCloner = (extend, base) ->
	obj = extend
	if base?
		obj = utils.clone extend
		utils.merge obj, base
		utils.merge base, obj
	json = JSON.stringify obj
	func = Function "return #{json}"
	func