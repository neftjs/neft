'use strict'

module.exports = (impl) ->
    qmlStr = "import QtQuick 2.3; import QtMultimedia 5.4; Component { Audio {} }"
    component = Qt.createQmlObject qmlStr, __stylesHatchery

    DATA =
        bindings: null
        elem: null

    DATA: DATA

    createData: impl.utils.createDataCloner DATA

    create: (data) ->
        data.elem ?= component.createObject()
        return

    setAmbientSoundSource: (val) ->
        unless impl.utils.DATA_URI_RE.test(val)
            if rsc = impl.Renderer.resources?.getResource(val)
                val = 'qrc:' + rsc.resolve()
            else
                val = impl.utils.toUrl(val)
        @_impl.elem.source = val
        return

    setAmbientSoundLoop: (val) ->
        @_impl.elem.loops = if val then __stylesWindow._Audio.Infinite else 1
        return

    startAmbientSound: (val) ->
        @_impl.elem.play();
        return

    stopAmbientSound: (val) ->
        @_impl.elem.stop();
        return