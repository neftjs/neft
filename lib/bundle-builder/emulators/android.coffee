'use strict'

module.exports = ->
    windiow: global
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
