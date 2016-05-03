neft:require @xml
=================

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

