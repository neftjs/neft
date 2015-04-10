neft:require @xml
=================

This special *XML* tag is used to include fragments from the local file.

All fragments ([neft:fragment][] tags) from the external file 
are available in the file where this tag has been used.

**href** is a local path relative to the file where it's used.

```
<neft:require href="./user_utils.html" />

<neft:use neft:fragment="avatar" />
```

#### Namespaces

For better organizations you can include external files into the namespace.

To do this, specify an **as** attribute.
Included fragments will be available under the given namespace.

```
<neft:require href="./user_utils.html" as="user" />

<neft:use neft:fragment="user:avatar" />
```

	'use strict'

	pathUtils = require 'path'

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

			# get view
			path = href
			if path[0] isnt '/'
				path = pathUtils.join '/', file.pathbase, path
			path = ///^\/(.+)\.html$///.exec(path)[1] or path
			links.push
				path: path
				namespace: namespace

		links
