'use strict'

[utils] = ['utils'].map require

module.exports = (File) -> (file, opts, elem) ->

	name = elem.name
	unit = file.units[name]

	oldChild = elem.node
	unless oldChild.visible then return

	# get unit and parse it
	usedUnit = File.factory unit

	opts.source = elem
	usedUnit.render opts
	opts.source = null

	file._tmp.usedUnits.push usedUnit

	newChild = usedUnit.node

	# replace
	file._tmp.parentChanges.push oldChild.parent, oldChild, newChild
	oldChild.parent.replace oldChild, newChild