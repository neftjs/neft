'use strict'

findEvents = (node) ->
	# find events
	events = null
	i = 0
	while (attr = node.attrs.item(i++))[0]?
		[attrKey, attrValue] = attr

		continue if attrKey.slice(0, 4) isnt 'x:on'
		continue if (attrKey[4]+'').toUpperCase() isnt attrKey[4]

		eventName = attrKey.slice 2

		events ?= {}
		events[eventName] = attrValue

	events

module.exports = (File) -> (file) ->

	{Style} = File
	styles = file.styles = []

	# parse tags with `style` attr
	forNode = (node, parentStyle, data) ->
		if attr = node.attrs.get 'x:style'
			style = new Style
				self: file
				node: node
				itemId: attr
				events: findEvents(node)
				parent: parentStyle
				isRepeat: !!data?.ids[attr]

			data?.ids[attr] = true

			unless parentStyle
				styles.push style

			parentStyle = style

			if style.isScope
				data =
					ids: {}

		for child in node.children
			if child instanceof File.Element.Tag
				forNode child, parentStyle, data
		null

	forNode file.node, null, null

	null