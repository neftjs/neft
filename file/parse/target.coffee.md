neft:target @xml
===========

This special *XML* tag is used in the [neft:fragment][] to define place,
where the [neft:use][] body should be placed.

In the example below, *superPower* tag will be placed in the *neft:target* place.

```
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
