> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Extension**

# Extension

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extension.litcoffee)

## Table of contents
* [Extension](#extension)
* [**Class** Extension](#class-extension)
  * [when](#when)
  * [onWhenChange](#onwhenchange)
  * [target](#target)
  * [onTargetChange](#ontargetchange)
  * [running](#running)
  * [onRunningChange](#onrunningchange)
  * [enable](#enable)
  * [disable](#disable)
* [Glossary](#glossary)

# **Class** Extension

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extension.litcoffee)

##when
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Extension::when</code></dd><dt>Prototype property of</dt><dd><i>Extension</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
##onWhenChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Extension::onWhenChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Extension</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extension.litcoffee#signal-extensiononwhenchangeboolean-oldvalue)

##target
<dl><dt>Syntax</dt><dd><code>&#x2A;Item&#x2A; Extension::target</code></dd><dt>Prototype property of</dt><dd><i>Extension</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></dd></dl>
##onTargetChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Extension::onTargetChange(&#x2A;Item&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Extension</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <a href="/Neft-io/neft/wiki/Renderer-Item-API#class-item">Item</a></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extension.litcoffee#signal-extensionontargetchangeitem-oldvalue)

##running
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; Extension::running</code></dd><dt>Prototype property of</dt><dd><i>Extension</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
##onRunningChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Extension::onRunningChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><i>Extension</i></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extension.litcoffee#signal-extensiononrunningchangeboolean-oldvalue)

##enable
<dl><dt>Syntax</dt><dd><code>Extension::enable()</code></dd><dt>Prototype method of</dt><dd><i>Extension</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extension.litcoffee#extensionenable)

##disable
<dl><dt>Syntax</dt><dd><code>Extension::disable()</code></dd><dt>Prototype method of</dt><dd><i>Extension</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extension.litcoffee#extensiondisable)

# Glossary

- [Renderer.Extension](#class-extension)

