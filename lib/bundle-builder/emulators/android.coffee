'use strict'

module.exports = ->
    window: global
    requestAnimationFrame: ->
    android: {}
    setImmediate: ->
    _neft:
        http:
            request: -> 0
            onResponse: ->
        native:
            transferData: ->
            onData: ->
