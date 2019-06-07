'use strict'

utils = require '../../../util'
{SignalsEmitter} = require '../../../signal'
assert = require '../../../assert'

module.exports = (Renderer, Impl, itemUtils) ->
    StatusBar = require('./screen/statusBar') Renderer, Impl, itemUtils
    NavigationBar = require('./screen/navigationBar') Renderer, Impl, itemUtils

    class Screen extends SignalsEmitter
        constructor: ->
            super()
            @_impl = bindings: null
            @_touch = false
            @_width = 1024
            @_height = 800
            @_orientation = 'Portrait'
            @_statusBar = new StatusBar
            @_navigationBar = new NavigationBar

            Object.preventExtensions @

        utils.defineProperty @::, 'touch', null, ->
            @_touch
        , null

        utils.defineProperty @::, 'width', null, ->
            @_width
        , null

        utils.defineProperty @::, 'height', null, ->
            @_height
        , null

        itemUtils.defineProperty
            constructor: @
            name: 'orientation'
            developmentSetter: (val) ->
                assert.isString val

        utils.defineProperty @::, 'statusBar', null, ->
            @_statusBar
        , null

        utils.defineProperty @::, 'navigationBar', null, ->
            @_navigationBar
        , null

    screen = new Screen
    Impl.initScreenNamespace.call screen, ->
        Impl.setWindowSize screen.width, screen.height
        return

    screen
