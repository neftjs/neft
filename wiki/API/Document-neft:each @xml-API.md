> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ [[File|Document-File @class-API]]

neft:each
<dl><dt>Syntax</dt><dd><code>neft:each @xml</code></dd></dl>
Attribute used for repeating.

Tag children will be duplicated for each
element defined in the `neft:each` attribute.

Supports arrays and [List][list/List] instances.

```xml
<ul neft:each="[1, 2]">
  <li>ping</li>
</ul>
```

In the tag children you have access to the three special variables:
- **each** - `neft:each` attribute,
- **item** - current element,
- **i** - current element index.

```xml
<ul neft:each="List(['New York', 'Paris', 'Warsaw'])">
  <li>Index: ${i}; Current: ${item}; Next: ${each[i+1]}</li>
</ul>
```

## Runtime changes

Use [List][list/List] to bind changes made in the array.

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file/parse/iterators.litcoffee#runtime-changes)
