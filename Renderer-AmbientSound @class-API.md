> [Wiki](Home) ▸ [API Reference](API-Reference)

AmbientSound
<dl><dt>Syntax</dt><dd>AmbientSound @class</dd></dl>
```nml
`AmbientSound {
`   running: true
`   source: '/static/sounds/bg.mp3'
`   loop: true
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#ambientsound-class)

New
<dl><dt>Syntax</dt><dd>*AmbientSound* AmbientSound.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])</dd><dt>Static method of</dt><dd><i>AmbientSound</i></dd><dt>Parameters</dt><dd><ul><li>component — <i>Component</i> — <i>optional</i></li><li>options — <i>Object</i> — <i>optional</i></li></ul></dd><dt>Returns</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#ambientsound-ambientsoundnewcomponent-component-object-options)

AmbientSound
<dl><dt>Syntax</dt><dd>*AmbientSound* AmbientSound()</dd><dt>Returns</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#ambientsound-ambientsound)

onStart
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) AmbientSound::onStart()</dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonstart)

onStop
<dl><dt>Syntax</dt><dd>[*Signal*](/Neft-io/neft/wiki/Signal-API.md#class-signal) AmbientSound::onStop()</dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd><dt>Returns</dt><dd><i>Signal</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonstop)

running
<dl><dt>Syntax</dt><dd>*Boolean* AmbientSound::running</dd><dt>Prototype property of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><i>Boolean</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#boolean-ambientsoundrunning-signal-ambientsoundonrunningchangeboolean-oldvalue)

source
<dl><dt>Syntax</dt><dd>*String* AmbientSound::source = ''</dd><dt>Prototype property of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><i>String</i></dd><dt>Default</dt><dd><code>''</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#string-ambientsoundsource---signal-ambientsoundonsourcechangestring-oldvalue)

loop
<dl><dt>Syntax</dt><dd>*Boolean* AmbientSound::loop = false</dd><dt>Prototype property of</dt><dd><i>AmbientSound</i></dd><dt>Type</dt><dd><i>Boolean</i></dd><dt>Default</dt><dd><code>false</code></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#boolean-ambientsoundloop--false-signal-ambientsoundonloopchangeboolean-oldvalue)

start
<dl><dt>Syntax</dt><dd>AmbientSound::start()</dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#ambientsoundstart)

stop
<dl><dt>Syntax</dt><dd>AmbientSound::stop()</dd><dt>Prototype method of</dt><dd><i>AmbientSound</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#ambientsoundstop)

