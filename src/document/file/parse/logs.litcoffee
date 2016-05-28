# neft:log

```xml
<neft:log debugObject="${props.someObject}">${props.debugText}</neft:log>
```

    'use strict'

    module.exports = (File) -> (file) ->
        {logs} = file

        for node in file.node.queryAll('neft:log')
            logs.push new File.Log file, node

        return

# Glossary

- [neft:log](#neft:log)
