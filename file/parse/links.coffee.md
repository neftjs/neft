neft:require @html
==================

Special HTML tag used to include view files units.

```
<neft:require href="user_utils.html" />

<neft:avatar />
```

Special `as` parameter defines alias.

```
<neft:require href="user_utils.html" as="user" />

<neft:user-avatar />
```

	'use strict'

	module.exports = (File) -> (file) ->

		# prepare
		links = []

		# load found files
		{children} = file.node
		i = -1
		n = children.length
		while ++i < n
			node = children[i]

			if node.name isnt "#{File.HTML_NS}:require"
				continue

			href = node.attrs.get 'href'
			unless href then continue

			namespace = node.attrs.get 'as'

			# remove link element
			node.parent = undefined
			i--; n--

			# get view
			view = File.factory file.pathbase + href
			links.push
				view: view
				namespace: namespace

		if links.length
			file.links = links
