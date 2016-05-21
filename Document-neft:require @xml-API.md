> [Wiki](Home) ▸ [[API Reference|API-Reference]]

neft:require
<dl><dt>Syntax</dt><dd><code>neft:require @xml</code></dd></dl>
Tag used to link [neft:fragment][document/neft:fragment@xml]s from a file and use them.

```xml
<neft:require href="./user_utils.html" />

<neft:use neft:fragment="avatar" />
```

## Namespace

Optional argument `as` will link all fragments into the specified namespace.

```xml
<neft:require href="./user_utils.html" as="user" />

<neft:use neft:fragment="user:avatar" />
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file/parse/fragments/links.litcoffee#namespace)

