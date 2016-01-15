neft:attr @xml
==============

Tag used to dynamically change an attribute of the parent element.

```xml
<header neft:style="header">
	<neft:attr name="isActive" value="true" neft:if="${data.isActive}" />
	<span neft:if="${isActive}">You are active</span>
</header>
```

	'use strict'

	module.exports = (File) ->
		{AttrChange} = File

		(file) ->
			{attrChanges} = file

			nodes = file.node.queryAll "neft:attr"

			for node in nodes
				target = node.parent
				name = node.getAttr 'name'

				unless target.hasAttr(name)
					target.setAttr name, ''

				attrChanges.push new AttrChange file, node, target, name

			return
