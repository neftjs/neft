> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ [[File|Document-File @class-API]]

neft:if
<dl><dt>Syntax</dt><dd><code>neft:if @xml</code></dd></dl>
Attribute used to hide or show the tag depends on the condition result.

```xml
<span neft:if="${user.isLogged}">Hi ${user.name}!</span>
<span neft:else>You need to log in</span>
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file/parse/conditions.litcoffee#neftif)

