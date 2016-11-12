> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]] ▸ **Animation**

# Animation

> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee)

## Nested APIs

* [[PropertyAnimation|Renderer-PropertyAnimation-API]]
  * [[NumberAnimation|Renderer-NumberAnimation-API]]

## Table of contents
* [Animation](#animation)
* [**Class** Animation](#class-animation)
  * [onStart](#onstart)
  * [onStop](#onstop)
  * [paused](#paused)
  * [onPausedChange](#onpausedchange)
  * [loop](#loop)
  * [onLoopChange](#onloopchange)
  * [updatePending](#updatepending)
  * [start](#start)
  * [stop](#stop)
  * [pause](#pause)
  * [resume](#resume)
* [Glossary](#glossary)

#**Class** Animation
<dl><dt>Syntax</dt><dd><code>&#x2A;&#x2A;Class&#x2A;&#x2A; Animation : &#x2A;Renderer.Extension&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Extension-API#class-extension">Renderer.Extension</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee#class-animation--rendererextension)

##onStart
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Animation::onStart()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee#signal-animationonstart)

##onStop
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Animation::onStop()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee#signal-animationonstop)

##paused
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Animation::paused</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
##onPausedChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Animation::onPausedChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee#signal-animationonpausedchangeboolean-oldvalue)

##loop
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; Animation::loop</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
##onLoopChange
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; Animation::onLoopChange(&#x2A;Boolean&#x2A; oldValue)</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd><dt>Parameters</dt><dd><ul><li>oldValue — <i>Boolean</i></li></ul></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee#signal-animationonloopchangeboolean-oldvalue)

##updatePending
<dl><dt>Syntax</dt><dd><code>ReadOnly &#x2A;Boolean&#x2A; Animation::updatePending</code></dd><dt>Prototype property of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Read Only</dt></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee#readonly-boolean-animationupdatepending)

##start
<dl><dt>Syntax</dt><dd><code>Animation::start()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee#animationstart)

##stop
<dl><dt>Syntax</dt><dd><code>Animation::stop()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee#animationstop)

##pause
<dl><dt>Syntax</dt><dd><code>Animation::pause()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee#animationpause)

##resume
<dl><dt>Syntax</dt><dd><code>Animation::resume()</code></dd><dt>Prototype method of</dt><dd><a href="/Neft-io/neft/wiki/Renderer-Animation-API#class-animation">Animation</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/8b1b771764f7b63d37551418b52ff56a86d16c1f/src/renderer/types/extensions/animation.litcoffee#animationresume)

# Glossary

- [Animation](#class-animation)

