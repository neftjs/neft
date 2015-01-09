neft:style @xml
===============

Special *XML* attribute used to connect `File.Element` with `Renderer.Item`.

As you know, `view` is used to organise your data in understood format and `Renderer` is
used to show some stuff (images, texts etc.) on the screen. We need to connect this two
things in some way - that's why `neft:style` *XML* attribute has been introduced.

This attribute value references to the `Renderer.Item::id` attribute.

By default, `Window` styles file is taken.

If used `Renderer.Item` defines `text` property, *XML* tag text will be used for it.

```nml,include(Window)
Rectangle {
\	color: 'gray'
\
\	Rectangle {
\		id: header
\		property text: ''
\		width: 100
\		height: 100
\		color: 'blue'
\
\		Text {
\			text: parent.text
\			color: 'white'
\			anchors.centerIn: parent
\		}
\	}
}
```

```view,example
<heading neft:style="header">Welcome!</heading>
```

Tags with this attributes creates special scopes, so you can easily put your styles file
into another `Renderer.Item`, just use capitalized file name.

```nml,include(ArticlesContact)
Text {
\	id: header
\	color: 'red'
}
```

```view,example
<contact neft:style="ArticlesContact">
  <heading neft:style="header">Contact</heading>
</contact>
```

### See also

- `neft:style`

.

	'use strict'

	findAttrs = (node) ->
		# find attrs
		attrs = null
		i = 0
		while (attr = node.attrs.item(i++))[0]?
			[attrKey, attrValue] = attr

			continue if attrKey.indexOf('neft:style:') isnt 0

			attrs ?= {}
			attrs[attrKey] = attrValue

		attrs

	module.exports = (File) -> (file) ->
		{Style} = File
		styles = file.styles = []

		# parse tags with `style` attr
		forNode = (node, parentStyle, data) ->
			if attr = node.attrs.get "#{File.HTML_NS}:style"
				isScope = ///^[A-Z]///.test attr

				style = new Style
					file: file
					node: node
					id: attr
					attrs: findAttrs(node)
					parent: parentStyle
					isRepeat: not isScope and !!data?.ids[attr]
					isScope: isScope

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