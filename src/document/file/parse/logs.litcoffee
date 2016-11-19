# <log />

This tag logs the given attributes and the whole body into console.

Each *string interpolation* change is detected and the whole tag is logged.

Example:

```xml
<log debugObject="${props.someObject}">${props.debugText}</log>
```

    'use strict'

    module.exports = (File) -> (file) ->
        {logs} = file

        for node in file.node.queryAll('log')
            logs.push new File.Log file, node

        return

# Glossary

- [<log />](#log)
