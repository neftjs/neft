neft:source @xml
================

Special XML tag used in `neft:unit`s to define place,
where the `neft:use` body should be placed.

```view,example
<neft:unit name="user">
  <name>#{name}</name>
  <age>#{age}</age>
  <neft:source />
</neft:unit>

<neft:use:user name="Max" age="19">
  <superPower>flying</superPower>
</neft:use:user>
```

### See also

- `neft:unit`
- `neft:use`
- `String Interpolation`

.

	'use strict'

	tmp = []

	module.exports = (File) -> (file) ->
		file.sourceNode = file.node.queryAll("#{File.HTML_NS}:source", tmp)[0]
