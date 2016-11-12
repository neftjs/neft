> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Document|Document-API]] ▸ **use**

# use

Tag used to place [component](/Neft-io/neft/wiki/Document-component-API#component).

```xml
<component name="user">
  This is a user
</component>

<use component="user" />
```

[component](/Neft-io/neft/wiki/Document-component-API#component) attribute can be changed in runtime.

```xml
<component name="h1">
  <h1>H1 heading</h1>
</component>

<use component="h${data.level}" />
```

Short version of [use](/Neft-io/neft/wiki/Document-use-API#use) is a tag prefixed by `use:`.

```xml
<component name="user">
  This is a user
</component>

<user />
```

[use](/Neft-io/neft/wiki/Document-use-API#use) attributes are available in [component](/Neft-io/neft/wiki/Document-component-API#component) scope.

```xml
<component name="heading">
  <h1>H1: ${props.data}</h1>
</component>

<heading data="Test heading" />
```

## Table of contents
* [use](#use)
  * [n-async](#nasync)
* [Glossary](#glossary)

## n-async

Renders component on the first free animation frame.

Use this attribute to render less important elements.

```xml
<body n-async />
```

> [`Source`](/Neft-io/neft/blob/42e53472888b24a14f8aa89b8417a63790934b26/src/document/file/parse/uses.litcoffee)

# Glossary

- [use](#use)

