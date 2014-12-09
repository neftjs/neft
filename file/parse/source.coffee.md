neft:source @html
=================

Special HTML tag used in `File.Unit` to define destination for the `File.Use` body.

```
<neft:unit name="user">
  <neft:source />
</neft:unit>

<neft:use:user>123</neft:use:user>
```

	'use strict'

	tmp = []

	module.exports = (File) -> (file) ->
		file.sourceNode = file.node.queryAll("#{File.HTML_NS}:source", tmp)[0]
