> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **AmbientSound**

# AmbientSound

```javascript
AmbientSound {
    running: true
    source: '/static/sounds/bg.mp3'
    loop: true
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee)

## Table of contents
* [AmbientSound](#ambientsound)
* [**Class** AmbientSound](#class-ambientsound)
  * [New](#new)
  * [onStart](#onstart)
  * [onStop](#onstop)
  * [running](#running)
  * [onRunningChange](#onrunningchange)
  * [source](#source)
  * [onSourceChange](#onsourcechange)
  * [*Boolean* AmbientSound::loop = false](#boolean-ambientsoundloop--false)
  * [onLoopChange](#onloopchange)
  * [start](#start)
  * [stop](#stop)
* [Glossary](#glossary)

# **Class** AmbientSound

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;AmbientSound&#x2A; AmbientSound.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#ambientsound-ambientsoundnewcomponent-component-object-options)

##onStart
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onStart()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonstart)

##onStop
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onStop()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonstop)

##running
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; AmbientSound::running</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
##onRunningChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onRunningChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonrunningchangeboolean-oldvalue)

##source
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; AmbientSound::source</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
##onSourceChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onSourceChange(&#x2A;String&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>String</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonsourcechangestring-oldvalue)

## *Boolean* AmbientSound::loop = false

##onLoopChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onLoopChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonloopchangeboolean-oldvalue)

##start
<dl><dt>Syntax</dt><dd><code>AmbientSound::start()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#ambientsoundstart)

##stop
<dl><dt>Syntax</dt><dd><code>AmbientSound::stop()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#ambientsoundstop)

# Glossary

- [AmbientSound](#class-ambientsound)

