> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Attributes evaluating
Some of the attributes are automatically evaluated to the JavaScript objects.
String `[...]` evaluates to the array.
```xml
<items neft:each="[1, 2]"></items>
```
```xml
<neft:use neft:fragment="list" items="[{name: 't-shirt'}]" />
```
String `{...}` evaluates to the object.
```xml
<neft:use neft:fragment="user" data="{name: 'Johny'}" />
```
String `Dict(...` evaluates to the [Dict][dict/Dict].
```xml
<neft:use neft:fragment="user" data="Dict({name: 'Johny'})" />
```
String `List(...` evaluates to the [List][list/List].
```xml
<items neft:each="List([1, 2])"></items>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/file/parse/attrs.litcoffee#attributes-evaluating-learn)

