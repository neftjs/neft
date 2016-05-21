> [Wiki](Home) ▸ [API Reference](API-Reference)

neft:if
<dl><dt>Syntax</dt><dd><code>neft:if @xml</code></dd></dl>
Attribute used to hide or show the tag depends on the condition result.
```xml
<span neft:if="${user.isLogged}">Hi ${user.name}!</span>
<span neft:else>You need to log in</span>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/file/parse/conditions.litcoffee#neftif-xml)

