# neft:require

Tag used to link *neft:fragment*s from a file and use them.

```xml
<neft:require href="./user_utils.html" />

<use:avatar />
```

## Namespace

Optional argument `as` will link all fragments into the specified namespace.

```xml
<neft:require href="./user_utils.html" as="user" />

<use:user:avatar />
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

            if node.name isnt "#{File.HTML_NS}:require"
                continue

            href = node.attrs.href or node.attrs.src
            unless href then continue

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

- [neft:require](#neft:require)
