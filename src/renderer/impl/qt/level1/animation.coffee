'use strict'

module.exports = (impl) ->
    DATA =
        bindings: null
        elem: null
        dirty: true

    DATA: DATA

    createData: impl.utils.createDataCloner DATA

    create: (data) ->

    setAnimationLoop: (val) ->