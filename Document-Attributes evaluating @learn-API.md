> [Wiki](Home) ▸ [[API Reference|API-Reference]]

Attributes evaluating
<dl><dt>Syntax</dt><dd><code>Attributes evaluating @learn</code></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file/parse/attrs.litcoffee#attributes-evaluating)

