'use strict'

utils = require 'utils/index.coffee.md'

module.exports = (File) -> (_super) -> (file, opts, callback) ->

	{usedUnits, changes} = file._tmp
	{units, elems, texts} = file

	if utils.isEmpty elems then return _super arguments...

	stack = new utils.async.Stack

	# replace elems by units
	for name, subelems of elems

		unit = units[name]

		for elem in subelems

			oldChild = elem.node
			unless oldChild.visible then continue

			# get unit and parse it
			usedUnit = unit.clone()
			stack.add usedUnit, 'render', source: elem
			usedUnits.push usedUnit

			newChild = usedUnit.node

			# replace
			changes.push oldChild.parent, oldChild, newChild
			oldChild.parent.replace oldChild, newChild

	# parse units
	args = arguments

	stack.runAllSimultaneously (err) ->

		if err then return callback err
		_super args...