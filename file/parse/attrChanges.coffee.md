neft:attr @html
===============

Special HTML tag using to create new `File.AttrChange`s.

```
<header neft:style="header">
  <neft:attr name="neft:style:state" value="active" neft:if="1 > 0" />
</header>
```

	'use strict'

	module.exports = (File) ->
		{AttrChange} = File

		(file) ->
			attrChanges = []

			nodes = file.node.queryAll "#{File.HTML_NS}:attr"

			for node in nodes
				target = node.parent
				name = node.attrs.get 'name'
				value = node.attrs.get 'value'

				if target.attrs.get(name) is undefined
					target.attrs.add name, value

				attrChanges.push new AttrChange
					self: file
					node: node
					target: target
					name: name
					value: value

			if attrChanges.length
				file.attrChanges = attrChanges

			null