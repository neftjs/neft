neft:target @xml
================

Tag used in the [neft:fragment][document/neft:fragment@xml] to define,
where the [neft:use][document/neft:use@xml] body should be placed.

```xml
<neft:fragment neft:name="user">
  <name>${name}</name>
  <age>${age}</age>
  <neft:target />
</neft:fragment>

<neft:use neft:fragment="user" name="Max" age="19">
  <superPower>flying</superPower>
</neft:use>
```

	'use strict'

	module.exports = (File) -> (file) ->
		file.targetNode = file.node.query("neft:target")
		file.targetNode?.name = 'neft:blank'
