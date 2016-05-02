Attributes evaluating @learn
============================

Some of the attributes are automatically evaluated to the JavaScript objects.

String `[...]` evaluates to the array.
```xml
<items neft:each="[1, 2]"></items>
```
```xml
<neft:use neft:fragment="list" items="[{name: 't-shirt'}]" />
```

String `{...}` evaluates to the object.
```xml
<neft:use neft:fragment="user" data="{name: 'Johny'}" />
```

String `Dict(...` evaluates to the [Dict][dict/Dict].
```xml
<neft:use neft:fragment="user" data="Dict({name: 'Johny'})" />
```

String `List(...` evaluates to the [List][list/List].
```xml
<items neft:each="List([1, 2])"></items>
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
