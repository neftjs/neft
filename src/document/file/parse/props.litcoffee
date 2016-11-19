# Attributes evaluating

Some of the attributes are automatically evaluated to JavaScript objects.

String `[...]` evaluates to an array.
```xml
<List n-each="[1, 2]" />
```
```xml
<List items="[{name: 't-shirt'}]" />
```

String `{...}` evaluates to an object.
```xml
<User data="{name: 'Johny'}" />
```

String `Dict(...` evaluates to *Dict*.
```xml
<User data="Dict({name: 'Johny'})" />
```

String `List(...` evaluates to *List*.
```xml
<List n-each="List([1, 2])" />
```

    'use strict'

    utils = require 'src/utils'
    Dict = require 'src/dict'
    List = require 'src/list'

    evalFunc = new Function 'val', 'Dict', 'List', 'try { return eval(\'(\'+val+\')\'); } catch(err){}'

    module.exports = (File) -> (file) ->
        {Tag} = File.Element
        {propsToParse} = file

        forNode = (elem) ->
            for name, val of elem.props when elem.props.hasOwnProperty(name)
                jsVal = evalFunc val, Dict, List
                if utils.isObject(jsVal)
                    propsToParse.push elem, name
                else if jsVal isnt undefined
                    elem.props.set name, jsVal

            for child in elem.children
                if child instanceof Tag
                    forNode child
            return

        forNode file.node
