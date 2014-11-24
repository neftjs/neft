neft:style @html
================

Special HTML attribute used to connect `File.Element` with the `Renderer.Item`.

```
<h1 neft:style="header">Welcome!</h1>
```

Style files
-----------

Each style file can be put by capitalizing its file name.

```
<div neft:style="ArticlesContact">
  <h1 neft:style="header">Contact</h1>
</div>
```

	'use strict'

	findEvents = (node) ->
		# find events
		events = null
		i = 0
		while (attr = node.attrs.item(i++))[0]?
			[attrKey, attrValue] = attr

			continue if attrKey.slice(0, 4) isnt 'neft:on'
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
			if attr = node.attrs.get "#{File.HTML_NS}:style"
				style = new Style
					self: file
					node: node
					id: attr
					events: findEvents(node)
					parent: parentStyle
					isRepeat: !!data?.ids[attr]
					isScope: ///^[A-Z]///.test attr

				data?.ids[attr] = true

				if style.isScope
					data = ids: {}

				unless parentStyle
					styles.push style

				parentStyle = style

			for child in node.children
				if child instanceof File.Element.Tag
					forNode child, parentStyle, data
			null

		forNode file.node, null, null

		null