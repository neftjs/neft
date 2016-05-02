'use strict'

module.exports = (impl) ->
    DATA =
        bindings: null

    DATA: DATA

    createData: impl.utils.createDataCloner DATA

    create: (data) ->

    setAmbientSoundSource: (val) ->

    setAmbientSoundLoop: (val) ->

    startAmbientSound: (val) ->

    stopAmbientSound: (val) ->
