# Attributes evaluating

Some of the attributes are automatically evaluated to the JavaScript objects.

String `[...]` evaluates to an array.
```xml
<use:list n-each="[1, 2]" />
```
```xml
<use:list items="[{name: 't-shirt'}]" />
```

String `{...}` evaluates to an object.
```xml
<use:user data="{name: 'Johny'}" />
```

String `Dict(...` evaluates to *Dict*.
```xml
<use:user data="Dict({name: 'Johny'})" />
```

String `List(...` evaluates to *List*.
```xml
<use:list n-each="List([1, 2])" />
```

    'use strict'

    utils = require 'src/utils'
    Dict = require 'src/dict'
    List = require 'src/list'

    evalFunc = new Function 'val', 'Dict', 'List', 'try { return eval(\'(\'+val+\')\'); } catch(err){}'

    module.exports = (File) -> (file) ->
        {Tag} = File.Element
        {attrsToParse} = file

        forNode = (elem) ->
            for name, val of elem.attrs when elem.attrs.hasOwnProperty(name)
                jsVal = evalFunc val, Dict, List
                if utils.isObject(jsVal)
                    attrsToParse.push elem, name
                else if jsVal isnt undefined
                    elem.attrs.set name, jsVal

            for child in elem.children
                if child instanceof Tag
                    forNode child
            return

        forNode file.node
