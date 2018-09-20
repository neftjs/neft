'use strict'

DeviceCtor = require 'src/renderer/types/namespace/device'

describe 'renderer Device', ->
    describe 'log()', ->
        it 'calls logDevice impl method properly', ->
            args = []
            Renderer = {}
            Impl =
                logDevice: (localArgs...) -> args.push localArgs
                initDeviceNamespace: ->
            itemUtils =
                defineProperty: ->
            Device = DeviceCtor Renderer, Impl, itemUtils
            Device.log 'a', 'b'
            assert.isEqual args, [['a b']]
