> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **neft:rule @xml**

neft:rule @xml
==============

Tag used in the parsing process.
Performs some actions on found elements in the parent element.

## Table of contents
  * [attrs](#attrs)

## attrs

Adds attributes if not exists.
```xml
<neft:rule query="input[type=string]">
  <attrs class="specialInput" />
</neft:rule>
```

> [`Source`](/Neft-io/neft/tree/master/src/document/file/parse/rules.litcoffee#attrs)

