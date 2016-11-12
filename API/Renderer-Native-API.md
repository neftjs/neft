> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ [[Item|Renderer-Item-API]] ▸ **Native**

# Native

> [`Source`](/Neft-io/neft/blob/5d7f4fa565689af73615efcc4eb2364a2326ce66/src/renderer/types/basics/item/types/native.litcoffee)

## Table of contents
* [Native](#native)
* [**Class** Native](#class-native)
  * [defineProperty](#defineproperty)
    * [Predefined types](#predefined-types)
      * [text](#text)
      * [number](#number)
      * [boolean](#boolean)
      * [color](#color)
  * [set](#set)
  * [call](#call)
  * [on](#on)
* [Glossary](#glossary)

#**Class** Native
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Native : &#x2A;Item&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/5d7f4fa565689af73615efcc4eb2364a2326ce66/src/renderer/types/basics/item/types/native.litcoffee#class-native--item)

##defineProperty
<dl><dt>Syntax</dt><dd><code>Native.defineProperty(&#x2A;Object&#x2A; config)</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Native-API#class-native">Native</a></dd><dt>Parameters</dt><dd><ul><li>config — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a></li></ul></dd></dl>
Defines new property with the given name.

For each property, signal `onXYZChange` is created,
where `XYZ` is the given name.

`config` parameter must be an object with specified keys:
- `enabled` - whether it's supported on current platform,
- `name` - name of the property,
- `type` - type of predefined condifuration described below,
- `defaultValue`,
- `setter`,
- `getter`,
- `developmentSetter`
- `implementationValue` - function returning value passed to the implementation.

### Predefined types

> [`Source`](/Neft-io/neft/blob/5d7f4fa565689af73615efcc4eb2364a2326ce66/src/renderer/types/basics/item/types/native.litcoffee)

#### text

> [`Source`](/Neft-io/neft/blob/5d7f4fa565689af73615efcc4eb2364a2326ce66/src/renderer/types/basics/item/types/native.litcoffee)

#### number

> [`Source`](/Neft-io/neft/blob/5d7f4fa565689af73615efcc4eb2364a2326ce66/src/renderer/types/basics/item/types/native.litcoffee)

#### boolean

> [`Source`](/Neft-io/neft/blob/5d7f4fa565689af73615efcc4eb2364a2326ce66/src/renderer/types/basics/item/types/native.litcoffee)

#### color

> [`Source`](/Neft-io/neft/blob/5d7f4fa565689af73615efcc4eb2364a2326ce66/src/renderer/types/basics/item/types/native.litcoffee)

##set
<dl><dt>Syntax</dt><dd><code>Native::set(&#x2A;String&#x2A; propName, &#x2A;Any&#x2A; val)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Native-API#class-native">Native</a></dd><dt>Parameters</dt><dd><ul><li>propName — <i>String</i></li><li>val — <i>Any</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/5d7f4fa565689af73615efcc4eb2364a2326ce66/src/renderer/types/basics/item/types/native.litcoffee#nativesetstring-propname-any-val)

##call
<dl><dt>Syntax</dt><dd><code>Native::call(&#x2A;String&#x2A; funcName, &#x2A;Any&#x2A; args...)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Native-API#class-native">Native</a></dd><dt>Parameters</dt><dd><ul><li>funcName — <i>String</i></li><li>args... — <i>Any</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/5d7f4fa565689af73615efcc4eb2364a2326ce66/src/renderer/types/basics/item/types/native.litcoffee#nativecallstring-funcname-any-args)

##on
<dl><dt>Syntax</dt><dd><code>Native::on(&#x2A;String&#x2A; eventName, &#x2A;Function&#x2A; listener)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Native-API#class-native">Native</a></dd><dt>Parameters</dt><dd><ul><li>eventName — <i>String</i></li><li>listener — <i>Function</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/5d7f4fa565689af73615efcc4eb2364a2326ce66/src/renderer/types/basics/item/types/native.litcoffee#nativeonstring-eventname-function-listener)

# Glossary

- [Native](#class-native)

