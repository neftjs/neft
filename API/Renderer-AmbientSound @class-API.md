> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[Renderer|Renderer-API]]

AmbientSound
<dl><dt>Syntax</dt><dd><code>AmbientSound @class</code></dd></dl>
```nml
`AmbientSound {
`   running: true
`   source: '/static/sounds/bg.mp3'
`   loop: true
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#ambientsound)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;AmbientSound&#x2A; AmbientSound.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>AmbientSound</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API#isobject">Object</a> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#new)

AmbientSound
<dl><dt>Syntax</dt><dd><code>&#x2A;AmbientSound&#x2A; AmbientSound()</code></dd><dt>Returns</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#ambientsound)

onStart
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onStart()</code></dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#onstart)

onStop
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onStop()</code></dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Signal-API#class-signal">Signal</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#onstop)

running
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; AmbientSound::running</code></dd><dt>Prototype property of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#running)

source
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; AmbientSound::source = ''</code></dd><dt>Prototype property of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>''</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#source)

loop
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; AmbientSound::loop = false</code></dd><dt>Prototype property of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#loop)

start
<dl><dt>Syntax</dt><dd><code>AmbientSound::start()</code></dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#start)

stop
<dl><dt>Syntax</dt><dd><code>AmbientSound::stop()</code></dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#stop)

