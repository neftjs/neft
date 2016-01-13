neft:style @xml
==========

This is a special *XML* attribute used to connect the [Document Modeling][] nodes with
the [Renderer.Item][] class.

As you know, views are used to organize your data in an understood format and [Rendering][]
is used to show some stuff (images, texts etc.) on the screen. We need to connect this two
things in some way - that's why [neft:style][] *XML* attribute has been introduced.

Using this attribute, you can create a new style file by using *style.* prefix,
or point to its item id.

```
// styles/home/header.js
Rectangle {
  anchors.fill: parent
  color: 'red'
  Text {
  	id: heading
  }
}

// views/index.html
<header neft:style="styles:home/header">
  <h1 neft:style="heading">Welcome!</h1>
</header>
```

If used [Renderer.Item][] has a *text* property (e.g. [Renderer.Text][]),
*XML* node text will be automatically set as a *text*.

```
// styles/header.js
Rectangle {
\  property text: ''
\  width: 100
\  height: 100
\  color: 'blue'
\
\  Text {
\    text: parent.text
\    color: 'white'
\    anchors.centerIn: parent
\  }
}

// views/index.html
<header neft:style="styles:header">Welcome!</header>
```

You can set any of the [Renderer.Item][] properties by using *neft:style:* namespace.

Your *XML* property value will be automatically converted to the expected format
(in the example below, both properties are converted into numbers).

```
// styles/player.js
Item {
  property stamina: 0.9
}

// views/player.html
<div neft:style="styles:player" stamina="0.7" style:width="10"></div>
```

	'use strict'

	module.exports = (File) -> (file) ->
		{Style} = File
		{styles} = file

		getStyleAttrs = (node) ->
			attrs = null
			for attr of node._attrs
				if attr is 'class' or attr.slice(0, 6) is 'style:'
					attrs ?= {}
					attrs[attr] = true
			attrs

		# parse tags with `style` attr
		forNode = (node, parentStyle) ->
			if attr = node.getAttr('neft:style')
				id = attr

				style = new Style
				style.file = file
				style.node = node
				style.parent = parentStyle
				style.attrs = getStyleAttrs node

				if parentStyle
					parentStyle.children.push style
				else
					styles.push style

				parentStyle = style

			for child in node.children
				if child instanceof File.Element.Tag
					forNode child, parentStyle
			return

		forNode file.node, null, null

		return
