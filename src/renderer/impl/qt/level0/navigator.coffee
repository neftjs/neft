'use strict'

module.exports = (impl) ->
    initNavigatorNamespace: ->
        @_impl = bindings: null
        @_browser = false
        @_language = Qt.locale().name.slice(0, 2)

        return