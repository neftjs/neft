> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Resources|Resources-API]] ▸ **Resource**

# Resource

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee#resource)

## Table of contents
* [Resource](#resource)
* [**Class** Resource](#class-resource)
  * [fromJSON](#fromjson)
  * [parseFileName](#parsefilename)
  * [*String* Resource::file = `''`](#string-resourcefile--)
  * [toJSON](#tojson)
* [Glossary](#glossary)

# *[Class](/Neft-io/neft/wiki/Renderer-Class-API#class-class)* Resource

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee#class-resource)

##fromJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Resource&#x2A; Resource.fromJSON(&#x2A;String&#x2A;|&#x2A;Object&#x2A; json)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Parameters</dt><dd><ul><li>json — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> or <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee#fromjson)

##parseFileName
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Resource.parseFileName(&#x2A;String&#x2A; name)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee#parsefilename)

## *String* Resource::file = `''`

## *String* Resource::color = `''`

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Resource::width = `0`

## [Float](/Neft-io/neft/wiki/Utils-API#isfloat) Resource::height = `0`

## *Array* Resource::formats

## *Array* Resource::resolutions

## [Object](/Neft-io/neft/wiki/Utils-API#isobject) Resource::paths

## *String* Resource::resolve([*String* uri, [Object](/Neft-io/neft/wiki/Utils-API#isobject) request])

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee#string-resourcefile---string-resourcecolor---float-resourcewidth--0-float-resourceheight--0-array-resourceformats-array-resourceresolutions-object-resourcepaths-string-resourceresolvestring-uri-object-request)

##toJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Resource::toJSON()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee#tojson)

# Glossary

- [Resource](#class-resource)

