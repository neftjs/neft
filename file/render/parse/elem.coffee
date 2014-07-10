'use strict'

[utils] = ['utils'].map require

module.exports = (File) -> (file, opts, elem) ->

	{usedUnits, changes} = file._tmp
	{units, elems, texts} = file

	name = elem.name
	unit = units[name]

	oldChild = elem.node
	unless oldChild.visible then return

	# get unit and parse it
	usedUnit = File.factory unit

	opts.source = elem
	usedUnit.render opts
	opts.source = null

	usedUnits.push usedUnit

	newChild = usedUnit.node

	# replace
	changes.push oldChild.parent, oldChild, newChild
	oldChild.parent.replace oldChild, newChild