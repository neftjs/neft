neft:if @xml
=======

This special *XML* attribute is used to hide or show tags depends on the condition result.

Considering the example below, the output always will be **1 is greater than 0**,
because the condition (*1 > 0*) is always true?

```
<text neft:if="1 > 0">1 is greater than 0</text>
<text neft:else>1 isn't greater than 0</text>
```

If we change the condition to the *0 > 1*, which of course is a false, we will get an empty
output, because the whole *span* tag will be omitted.

In practice, you will use the string interpolation to conditioning the result.

```
<name neft:if="user.age > 18">#{user.login}</name>
```

	'use strict'

	log = require 'log'

	log = log.scope 'View', 'Condition'

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
