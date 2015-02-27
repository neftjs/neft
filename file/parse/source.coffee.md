neft:source @xml
================

This special *XML* tag is used in the [neft:fragment][] to define place,
where the [neft:use][] body should be placed.

In the example below, *superPower* tag will be placed in the *neft:source* place.

```
<neft:fragment neft:name="user">
  <name>${name}</name>
  <age>${age}</age>
  <neft:source />
</neft:fragment>

<neft:use neft:fragment="user" name="Max" age="19">
  <superPower>flying</superPower>
</neft:use>
```

	'use strict'

	tmp = []

	module.exports = (File) -> (file) ->
		file.sourceNode = file.node.queryAll("#{File.HTML_NS}:source", tmp)[0]
