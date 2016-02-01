neft:require @xml
=================

Tag used to link [neft:fragment][document/neft:fragment@xml]s from a file and use them.

```xml
<neft:require href="./user_utils.html" />

<neft:use neft:fragment="avatar" />
```

## Namespace

Optional argument `as` will link all fragments into the specified namespace.

```xml
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
				pathbase = file.path.substring 0, file.path.lastIndexOf('/') + 1
				path = pathUtils.join '/', pathbase, path
			path = ///^(?:\/|\\)(.+)\.html$///.exec(path)?[1] or path
			links.push
				path: path
				namespace: namespace

		links
