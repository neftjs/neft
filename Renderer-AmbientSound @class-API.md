> [Wiki](Home) ▸ [API Reference](API-Reference)

AmbientSound
<dl><dt>Syntax</dt><dd><code>AmbientSound @class</code></dd></dl>
```nml
`AmbientSound {
`   running: true
`   source: '/static/sounds/bg.mp3'
`   loop: true
`}
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#ambientsound-class)

New
<dl><dt>Syntax</dt><dd><code>&#x2A;AmbientSound&#x2A; AmbientSound.New([&#x2A;Component&#x2A; component, &#x2A;Object&#x2A; options])</code></dd><dt>Static method of</dt><dd><i>AmbientSound</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#ambientsound-ambientsoundnewcomponent-component-object-options)

AmbientSound
<dl><dt>Syntax</dt><dd><code>&#x2A;AmbientSound&#x2A; AmbientSound()</code></dd><dt>Returns</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#ambientsound-ambientsound)

onStart
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onStart()</code></dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonstart)

onStop
<dl><dt>Syntax</dt><dd><code>&#x2A;Signal&#x2A; AmbientSound::onStop()</code></dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonstop)

running
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; AmbientSound::running</code></dd><dt>Prototype property of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#boolean-ambientsoundrunning-signal-ambientsoundonrunningchangeboolean-oldvalue)

source
<dl><dt>Syntax</dt><dd><code>&#x2A;String&#x2A; AmbientSound::source = ''</code></dd><dt>Prototype property of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>''</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#string-ambientsoundsource---signal-ambientsoundonsourcechangestring-oldvalue)

loop
<dl><dt>Syntax</dt><dd><code>&#x2A;Boolean&#x2A; AmbientSound::loop = false</code></dd><dt>Prototype property of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#boolean-ambientsoundloop--false-signal-ambientsoundonloopchangeboolean-oldvalue)

start
<dl><dt>Syntax</dt><dd><code>AmbientSound::start()</code></dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#ambientsoundstart)

stop
<dl><dt>Syntax</dt><dd><code>AmbientSound::stop()</code></dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/renderer/types/sound/ambient.litcoffee#ambientsoundstop)

