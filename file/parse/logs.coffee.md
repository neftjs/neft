neft:log @xml
=============

```xml
<neft:log debugObject="${data.someObject}">${debugText}</neft:log>
```

	'use strict'

	module.exports = (File) -> (file) ->
		{logs} = file

		for node in file.node.queryAll('neft:log')
			logs.push new File.Log file, node

		return