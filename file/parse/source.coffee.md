neft:source @html
=================

Special HTML tag used in `File.Unit` to define destination for the `File.Use` body.

```
<neft:unit="user">
  <neft:source />
</neft:unit>

<neft:user>123</neft:user>
```

	'use strict'

	tmp = []

	module.exports = (File) -> (file) ->
		file.sourceNode = file.node.queryAll("#{File.HTML_NS}:source", tmp)[0]
