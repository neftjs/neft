'use strict'

TOUCH_OS =
    android: true
    blackberry: true
    ios: true
    wince: true
    winrt: true
    winphone: true

module.exports = (impl) ->
    initScreenNamespace: ->
        {screen} = __stylesWindow
        @_width = screen.width
        @_height = screen.height
        @_touch = !!TOUCH_OS[Qt.platform.os]

        # orientation
        getOrientation = ->
            if screen.orientation & Qt.InvertedLandscapeOrientation
                'InvertedLandscape'
            else if screen.orientation & Qt.InvertedPortraitOrientation
                'InvertedPortrait'
            else if screen.orientation & Qt.LandscapeOrientation
                'Landscape'
            else
                'Portrait'

        updateOrientation = ->
            oldVal = @_orientation
            @_orientation = getOrientation()
            @onOrientationChange.emit oldVal
            return

        screen.orientationUpdateMask = Qt.LandscapeOrientation | Qt.PortraitOrientation |
                                       Qt.InvertedLandscapeOrientation |
                                       Qt.InvertedPortraitOrientation;

        @_orientation = getOrientation()
        screen.orientationChanged.connect @, updateOrientation

        return