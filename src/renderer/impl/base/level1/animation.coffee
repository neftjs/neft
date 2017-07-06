'use strict'

module.exports = (impl) ->
    DATA =
        bindings: null
        reversed: false

    DATA: DATA

    createData: impl.utils.createDataCloner DATA

    create: (data) ->

    setAnimationLoop: (val) ->

    setAnimationReversed: (val) ->
        @_impl.reversed = val
        return

    startAnimation: ->

    stopAnimation: ->

    resumeAnimation: ->

    pauseAnimation: ->
