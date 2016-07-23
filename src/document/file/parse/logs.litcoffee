# log

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

- [log](#log)
