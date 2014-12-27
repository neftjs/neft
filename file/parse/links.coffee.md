neft:require @xml
=================

Special XML tag used to include units from other local files.

All units (`neft:unit` tags) from the file defined by the `href`
are available in file where this tag has been used.

`href` is a local path relative to the file when it's used.

```
<neft:require href="user_utils.html" />

<neft:use:avatar />
```

### Namespaces

For better organizations, you can include external files into the namespaces.

Just specify an `as` attribute.
To each included unit, this alias will be prefixed in schema as below.

```
<neft:require href="user_utils.html" as="user" />

<neft:use:user-avatar />
```

### See also

- `neft:unit`
- `neft:use`

.

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
