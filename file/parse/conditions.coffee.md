neft:if @xml
=======

Attribute used to hide or show the tag depends on the condition result.

```xml
<span neft:if="${user.isLogged}">Hi ${user.name}!</span>
<span neft:else>You need to log in</span>
```

	'use strict'

	module.exports = (File) ->
		{Condition} = File

		(file) ->
			{conditions} = file

			forEachNodeRec = (node) ->
				for child in node.children
					unless child instanceof File.Element.Tag
						continue

					forEachNodeRec child

					if child.hasAttr('neft:if')
						elseNode = null
						if child.nextSibling?.hasAttr?('neft:else')
							elseNode = child.nextSibling

						conditions.push new File.Condition file, child, elseNode
				return

			forEachNodeRec file.node
