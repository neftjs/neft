> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Resources|Resources-API]] ▸ **Resource**

# Resource

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee)

## Table of contents
* [Resource](#resource)
* [**Class** Resource](#class-resource)
  * [fromJSON](#fromjson)
  * [parseFileName](#parsefilename)
  * [file](#file)
  * [color](#color)
  * [width](#width)
  * [height](#height)
  * [formats](#formats)
  * [resolutions](#resolutions)
  * [paths](#paths)
  * [resolve](#resolve)
  * [toJSON](#tojson)
* [Glossary](#glossary)

# **Class** Resource

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee)

##fromJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Resource&#x2A; Resource.fromJSON(&#x2A;String&#x2A;|&#x2A;Object&#x2A; json)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Parameters</dt><dd><ul><li>json — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> or <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee#resource-resourcefromjsonstringobject-json)

##parseFileName
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Resource.parseFileName(&#x2A;String&#x2A; name)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Parameters</dt><dd><ul><li>name — <i>String</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee#object-resourceparsefilenamestring-name)

##file
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Resource::file = `''`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>''</code></dd></dl>
##color
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Resource::color = `''`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>''</code></dd></dl>
##width
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Resource::width = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##height
<dl><dt>Syntax</dt><dd><code>&#x2A;Float&#x2A; Resource::height = `0`</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isfloat">Float</a></dd><dt>Default</dt><dd><code>0</code></dd></dl>
##formats
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Resource::formats</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
##resolutions
<dl><dt>Syntax</dt><dd><code>&#x2A;Array&#x2A; Resource::resolutions</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Type</dt><dd><i>Array</i></dd></dl>
##paths
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Resource::paths</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
##resolve
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; Resource::resolve([&#x2A;String&#x2A; uri, &#x2A;Object&#x2A; request])</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Parameters</dt><dd><ul><li>uri — <i>String</i> — <i>optional</i></li><li>request — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee#string-resourceresolvestring-uri-object-request)

##toJSON
<dl><dt>Syntax</dt><dd><code>&#x2A;Object&#x2A; Resource::toJSON()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Resources-Resource-API#class-resource">Resource</a></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/resources/resource.litcoffee#object-resourcetojson)

# Glossary

- [Resource](#class-resource)

