neft:rule @xml
==============

Tag used in the parsing process.
Performs some actions on found elements in the parent element.

## attrs

Adds attributes if not exists.

```xml
<neft:rule query="input[type=string]">
  <attrs class="specialInput" />
</neft:rule>
```

