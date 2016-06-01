> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **AmbientSound**

# AmbientSound

```javascript
AmbientSound {
    running: true
    source: '/static/sounds/bg.mp3'
    loop: true
}
```

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#ambientsound)

## Table of contents
* [AmbientSound](#ambientsound)
* [**Class** AmbientSound](#class-ambientsound)
  * [New](#new)
  * [onStart](#onstart)
  * [onStop](#onstop)
  * [running](#running)
  * [source](#source)
  * [*Boolean* AmbientSound::loop = false](#boolean-ambientsoundloop--false)
  * [start](#start)
  * [stop](#stop)
* [Glossary](#glossary)

# **Class** AmbientSound

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#class-ambientsound)

##New
<dl><dt>Syntax</dt><dd><code>&#x2A;AmbientSound&#x2A; AmbientSound.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#new)

##onStart
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onStart()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#onstart)

##onStop
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onStop()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#onstop)

##running
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; AmbientSound::running</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#running)

##source
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; AmbientSound::source</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd><dt>Type</dt><dd><i>String</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#source)

## *Boolean* AmbientSound::loop = false

## [Signal](/Neft-io/neft/wiki/Signal-API#class-signal) AmbientSound::onLoopChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#boolean-ambientsoundloop--false-signal-ambientsoundonloopchangeboolean-oldvalue)

##start
<dl><dt>Syntax</dt><dd><code>AmbientSound::start()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#start)

##stop
<dl><dt>Syntax</dt><dd><code>AmbientSound::stop()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-AmbientSound-API#class-ambientsound">AmbientSound</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/sound/ambient.litcoffee#stop)

# Glossary

- [AmbientSound](#class-ambientsound)

