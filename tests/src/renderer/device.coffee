'use strict'

{unit, assert, Renderer} = Neft
{describe, it, beforeEach} = unit
{Device} = Renderer
Impl = Renderer._Impl

describe 'src/renderer Device', ->
    describe 'log()', ->
        it 'calls logDevice impl method properly', ->
            {logDevice} = Impl
            args = []
            Impl.logDevice = (localArgs...) -> args.push localArgs
            Device.log 'a', 'b'
            assert.isEqual args, [['a b']]
            Impl.logDevice = logDevice
