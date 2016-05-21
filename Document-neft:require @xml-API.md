> [Wiki](Home) ▸ [API Reference](API-Reference)

neft:require
<dl></dl>
Tag used to link [neft:fragment][document/neft:fragment@xml]s from a file and use them.
```xml
<neft:require href="./user_utils.html" />
<neft:use neft:fragment="avatar" />
```

## Table of contents
    * [neft:require](#neftrequire)
  * [Namespace](#namespace)

## Namespace

Optional argument `as` will link all fragments into the specified namespace.
```xml
<neft:require href="./user_utils.html" as="user" />
<neft:use neft:fragment="user:avatar" />
```

> [`Source`](/Neft-io/neft/tree/master/src/document/file/parse/fragments/links.litcoffee#namespace)

