'use strict'

{Resources, utils} = Neft
{Resource} = Resources

describe 'Resources.Resource', ->
    describe 'parseFileName()', ->
        {parseFileName} = Resource

        it 'returns undefined for empty string', ->
            assert.is parseFileName(''), undefined

        it 'parses file', ->
            assert.is parseFileName('abc123').file, 'abc123'

        it 'sets undefined file for unspecified', ->
            assert.is parseFileName('#png').file, undefined

        it 'parses resolution', ->
            assert.is parseFileName('abc123@2x').resolution, 2

        it 'parses float resolution', ->
            assert.is parseFileName('abc123@2p5x').resolution, 2.5

        it 'sets undefined resolution for unspecified', ->
            assert.is parseFileName('abc123').resolution, undefined

        it 'parses format', ->
            assert.is parseFileName('abc123.png').format, 'png'

        it 'parses property', ->
            assert.is parseFileName('abc123#prop1').property, 'prop1'

    describe 'resolve()', ->
        beforeEach ->
            @rsc = new Resource
            @rsc.width = @width = Math.random()
            @rsc.file = @file = utils.uid()
            @rsc.color = @color = utils.uid()
            @format = utils.uid()
            @path1x = utils.uid()
            @path1p5x = utils.uid()
            @path2x = utils.uid()
            @rsc.resolutions = [1, 1.5, 2]
            @rsc.formats = [@format]
            @rsc.paths = @paths =
                "#{@format}":
                    1: @path1x
                    1.5: @path1p5x
                    2: @path2x

        it 'returns uri property', ->
            assert.is @rsc.resolve('#color'), @color

        it 'returns requested property', ->
            assert.is @rsc.resolve(property: 'color'), @color

        it 'returns uri property over requested proeprty', ->
            assert.is @rsc.resolve('#width', property: 'color'), @width

        it 'returns undefined for invalid uri file', ->
            assert.is @rsc.resolve('abc'), undefined

        it 'returns undefined for invalid requested file', ->
            assert.is @rsc.resolve(file: 'abc'), undefined

        it 'returns first path for resolution 1 by default', ->
            assert.is @rsc.resolve(), @path1x

        it 'returns uri resolution', ->
            assert.is @rsc.resolve('@1p5x'), @path1p5x

        it 'returns requested resolution', ->
            assert.is @rsc.resolve(resolution: 1.5), @path1p5x

        it 'returns uri format and resolution', ->
            assert.is @rsc.resolve("@1p5x.#{@format}"), @path1p5x

        it 'returns requested format and resolution', ->
            assert.is @rsc.resolve(format: @format, resolution: 1.5), @path1p5x

        it 'returns undefined for unknown uri format', ->
            assert.is @rsc.resolve('.abc'), undefined

        it 'returns undefined for unknown requested format', ->
            assert.is @rsc.resolve(formats: ['abc']), undefined

        it 'returns path with best uri resolution', ->
            assert.is @rsc.resolve('@1p4x'), @path1p5x
            assert.is @rsc.resolve('@1p2x'), @path1x
            assert.is @rsc.resolve('@1p8x'), @path2x

        it 'returns path with best uri resolution and requested format', ->
            assert.is @rsc.resolve('@1p4x', formats: [@format]), @path1p5x

        it 'returns path with best requested size', ->
            @rsc.width = 200
            @rsc.height = 100
            assert.is @rsc.resolve(width: 200, height: 100), @path1x
            assert.is @rsc.resolve(width: 300, height: 150), @path1p5x
            assert.is @rsc.resolve(width: 350, height: 150), @path2x
            assert.is @rsc.resolve(width: 400, height: 200), @path2x
            assert.is @rsc.resolve(width: 900, height: 500), @path2x
