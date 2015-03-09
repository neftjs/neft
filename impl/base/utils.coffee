utils = require 'utils'

module.exports = (impl) ->

	SETTER_METHODS_NAMES:
		'x': 'setItemX'
		'y': 'setItemY'
		'width': 'setItemWidth'
		'height': 'setItemHeight'
		'opacity': 'setItemOpacity'
		'rotation': 'setItemRotation'
		'scale': 'setItemScale'

	grid: require './utils/grid'

	createDataCloner: (extend, base) ->
		->
			obj = extend
			if base?
				extend = impl.Types[extend].DATA
				obj = utils.clone extend
				utils.merge obj, base
				utils.merge base, obj
			json = JSON.stringify obj
			func = Function "return #{json}"
			func