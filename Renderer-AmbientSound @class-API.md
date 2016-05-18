> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **AmbientSound @class**

AmbientSound @class
===================

```nml
`AmbientSound {
`   running: true
`   source: '/static/sounds/bg.mp3'
`   loop: true
`}
```

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#ambientsound-class)

## Table of contents
  * [AmbientSound.New([component, options])](#ambientsound-ambientsoundnewcomponent-component-object-options)
  * [AmbientSound()](#ambientsound-ambientsound)
  * [onStart()](#signal-ambientsoundonstart)
  * [onStop()](#signal-ambientsoundonstop)
  * [running](#boolean-ambientsoundrunning)
  * [source = ''](#string-ambientsoundsource--)
  * [loop = false](#boolean-ambientsoundloop--false)
  * [start()](#ambientsoundstart)
  * [stop()](#ambientsoundstop)

*AmbientSound* AmbientSound.New([*Component* component, [*Object*](/Neft-io/neft/wiki/Utils-API.md#boolean-isobjectany-value) options])
--------------------------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#ambientsound-ambientsoundnewcomponent-component-object-options)

*AmbientSound* AmbientSound()
-----------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#ambientsound-ambientsound)

*Signal* AmbientSound::onStart()
--------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonstart)

*Signal* AmbientSound::onStop()
-------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#signal-ambientsoundonstop)

*Boolean* AmbientSound::running
-------------------------------
## *Signal* AmbientSound::onRunningChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#boolean-ambientsoundrunning-signal-ambientsoundonrunningchangeboolean-oldvalue)

*String* AmbientSound::source = ''
----------------------------------
## *Signal* AmbientSound::onSourceChange(*String* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#string-ambientsoundsource---signal-ambientsoundonsourcechangestring-oldvalue)

*Boolean* AmbientSound::loop = false
------------------------------------
## *Signal* AmbientSound::onLoopChange(*Boolean* oldValue)

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#boolean-ambientsoundloop--false-signal-ambientsoundonloopchangeboolean-oldvalue)

AmbientSound::start()
---------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#ambientsoundstart)

AmbientSound::stop()
--------------------

> [`Source`](/Neft-io/neft/tree/master/src/renderer/types/sound/ambient.litcoffee#ambientsoundstop)

