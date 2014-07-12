'use strict'

module.exports = (File) -> (file) ->

	{parentChanges, attrChanges, visibleChanges} = file._tmp

	# back parent changes
	while parentChanges.length
		newChild = parentChanges.pop()
		oldChild = parentChanges.pop()
		node = parentChanges.pop()

		unless newChild
			oldChild.parent = node
			continue

		unless oldChild
			newChild.parent = undefined
			continue

		node.replace newChild, oldChild

	# back attr changes
	while attrChanges.length
		oldValue = attrChanges.pop()
		name = attrChanges.pop()
		node = attrChanges.pop()

		node.attrs.set name, oldValue

	# back visibility changes
	while visibleChanges.length
		node = visibleChanges.pop()

		node.visible = not node.visible

	null