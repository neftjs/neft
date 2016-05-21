> [Wiki](Home) ▸ [[API Reference|API-Reference]]

neft:target
<dl><dt>Syntax</dt><dd><code>neft:target @xml</code></dd></dl>
Tag used in the [neft:fragment][document/neft:fragment@xml] to define,
where the [neft:use][document/neft:use@xml] body should be placed.

```xml
<neft:fragment neft:name="user">
  <name>${name}</name>
  <age>${age}</age>
  <neft:target />
</neft:fragment>

<neft:use neft:fragment="user" name="Max" age="19">
  <superPower>flying</superPower>
</neft:use>
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/document/file/parse/target.litcoffee#nefttarget)

