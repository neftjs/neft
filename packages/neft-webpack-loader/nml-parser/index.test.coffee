'use strict'

fs = require 'fs'
pathUtils = require 'path'
nmlParser = require './'

bundle = (nml, options) ->
    nmlParser.bundle(nml, options).bundle

PREFIX = '''const exports = {}

const Renderer = require('@neft/core/src/renderer')
const _RendererObject = Renderer.itemUtils.Object'''

DEFAULT_IMPORTS = '''
const Class = Renderer.Class
const Device = Renderer.Device
const Navigator = Renderer.Navigator
const Screen = Renderer.Screen
'''

it 'bundles items', ->
    result = bundle '''
        @Item any-item {}
    ''', {}
    expected = """
        #{PREFIX}
        #{DEFAULT_IMPORTS}
        const Item = Renderer.Item
        exports._i0 = () => {
          const _i0 = Item.New()
          _RendererObject.setOpts(_i0, {"query": 'any-item'})
          _i0.onReady.emit()
          return { objects: {"_i0": _i0}, item: _i0 }
        }
        return exports
    """
    assert.is result, expected

it 'appends constants', ->
    result = bundle '''
        const abc = 1
        const func = function () {return 2}
        @Item {}
    ''', {}
    expected = """
        #{PREFIX}
        #{DEFAULT_IMPORTS}
        const Item = Renderer.Item
        const abc = 1
        const func = function () {return 2}

        exports._i0 = () => {
          const _i0 = Item.New()
          _i0.onReady.emit()
          return { objects: {"_i0": _i0}, item: _i0 }
        }
        return exports
    """
    assert.is result, expected
