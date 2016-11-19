# <import />

This tag is used to import *component*s from other file.

The *href* attribute can be an absolute path (e.g. `/file.xml`),
relative to the current file position (e.g. `./file.xml`), or
relative for the *views* folder (e.g. `file.xml`).

All imported files are accessible.

Example:

```xml
<import href="./user_utils.html" />
<Avatar />
```

Optional **as** attribute specifies a namespace for imported components.

Example:

```xml
<import href="./user_utils.html" as="User" />
<User:Avatar />
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

            href = node.props.href or node.props.src
            unless href then continue

            # hide element
            node.name = 'blank'

            namespace = node.props.as

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
- [<import />](#import)
