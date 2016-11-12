> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **Attributes evaluating**

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

String `Dict(...` evaluates to [Dict](/Neft-io/neft/wiki/Dict-API#class-dict).
```xml
<use:user data="Dict({name: 'Johny'})" />
```

String `List(...` evaluates to [List](/Neft-io/neft/wiki/List-API#class-list).
```xml
<use:list n-each="List([1, 2])" />
```

> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/file/parse/props.litcoffee)

