> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **Attributes evaluating**

# Attributes evaluating

Some of the attributes are automatically evaluated to the JavaScript objects.

String `[...]` evaluates to an array.
```xml
<use:list neft:each="[1, 2]" />
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
<use:list neft:each="List([1, 2])" />
```

> [`Source`](/Neft-io/neft/blob/b07f8471f0eea285e6ecaed7d5dc667674e2a4ae/src/document/file/parse/attrs.litcoffee#attributes-evaluating)

