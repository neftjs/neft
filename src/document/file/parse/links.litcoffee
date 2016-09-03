# import

Tag used to link *component*s from a file and use them.

```xml
<import href="./user_utils.html" />
<avatar />
```

## Namespace

Optional argument `as` will link all components into the specified namespace.

```xml
<import href="./user_utils.html" as="user" />
<user:avatar />
```

    'use strict'

    pathUtils = require 'path'

    module.exports = (File) -> (file) ->
        # prepare
        links = []

        # load found files
        {children} = file.node
        i = -1
        n = children.length
        while ++i < n
            node = children[i]

            if node.name isnt 'import'
                continue

            href = node.attrs.href or node.attrs.src
            unless href then continue

            # hide element
            node.name = 'blank'

            namespace = node.attrs.as

            # get view
            path = getFilePath File, file, href
            links.push
                path: path
                namespace: namespace

        links

    getFilePath = module.exports.getFilePath = (File, file, path) ->
        if pathUtils.isAbsolute(path)
            return path

        if path[0] is '.' and path[1] is '/'
            dirname = pathUtils.dirname file.path
            return pathUtils.join(dirname, path)

        pathUtils.join File.FILES_PATH, path

# Glossary

- [import](#import)
