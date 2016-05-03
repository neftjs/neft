AmbientSound @class
===================

```nml
`AmbientSound {
`   running: true
`   source: '/static/sounds/bg.mp3'
`   loop: true
`}
```

*AmbientSound* AmbientSound.New([*Component* component, *Object* options])
--------------------------------------------------------------------------

*AmbientSound* AmbientSound()
-----------------------------

*Signal* AmbientSound::onStart()
--------------------------------

*Signal* AmbientSound::onStop()
-------------------------------

*Boolean* AmbientSound::running
-------------------------------

## *Signal* AmbientSound::onRunningChange(*Boolean* oldValue)

*String* AmbientSound::source = ''
----------------------------------

## *Signal* AmbientSound::onSourceChange(*String* oldValue)

*Boolean* AmbientSound::loop = false
------------------------------------

## *Signal* AmbientSound::onLoopChange(*Boolean* oldValue)

AmbientSound::start()
---------------------

AmbientSound::stop()
--------------------

