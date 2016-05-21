> [Wiki](Home) ▸ [API Reference](API-Reference)

neft:rule
<dl><dt>Syntax</dt><dd><code>neft:rule @xml</code></dd></dl>
Tag used in the parsing process.
Performs some actions on found elements in the parent element.

## attrs

Adds attributes if not exists.
```xml
<neft:rule query="input[type=string]">
  <attrs class="specialInput" />
</neft:rule>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/file/parse/rules.litcoffee#attrs)

