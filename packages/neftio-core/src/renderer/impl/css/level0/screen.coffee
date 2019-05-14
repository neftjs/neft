'use strict'

module.exports = (impl) ->
    initScreenNamespace: ->
        screen = @

        @_width = screen.width
        @_height = screen.height
        @_touch = 'ontouchstart' of window

        getOrientation = =>
            screen.orientation = switch window.orientation
                when 180
                    'InvertedPortrait'
                when -90
                    'Landscape'
                when 90
                    'InvertedLandscape'
                else
                    'Portrait'
            return

        window.addEventListener 'orientationchange', getOrientation
        window.addEventListener 'load', ->
            getOrientation()
            setTimeout getOrientation, 1000
