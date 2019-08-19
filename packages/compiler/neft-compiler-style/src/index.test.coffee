'use strict'

fs = require 'fs'
pathUtils = require 'path'
nmlParser = require './'

bundle = (nml, options) ->
    nmlParser.bundle(nml, options).bundle

PREFIX = '''const exports = {}

const { Renderer } = require('@neft/core')
const _RendererObject = Renderer.itemUtils.Object'''

DEFAULT_IMPORTS = '''
const Class = Renderer.Class
const device = Renderer.device
const navigator = Renderer.navigator
const screen = Renderer.screen
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
          return { objects: {"_i0": _i0}, item: _i0 }
        }
        return exports
    """
    assert.is result, expected

it 'bundles top level selects', ->
    result = bundle '''
        a > b {
            color: 'red'
        }

        div {
            strong {
                font.weight: 1
            }
        }
    ''', {}
    expected = """
        #{PREFIX}
        #{DEFAULT_IMPORTS}
        exports.selects = []
        exports.selects.push(() => {
          const _r0 = Class.New()
          _RendererObject.setOpts(_r0, {\
          "document.query": 'a > b', \
          "document.queryElements": [function(){return __elements}, []], \
          "changes": {"color": 'red'}})
          return { objects: {"_r0": _r0}, select: _r0 }
        })
        exports.selects.push(() => {
          const _r0 = Class.New()
          _RendererObject.setOpts(_r0, {\
          "document.query": 'div', \
          "document.queryElements": [function(){return __elements}, []], \
          "changes": [], \
          "nesting": function(){
          const _r10 = Class.New()
          return [_RendererObject.setOpts(_r10, {\
          "document.query": 'strong', \
          "document.queryElements": [function(){return __elements}, []], \
          "changes": {"font.weight": 1}\
          })]
          }})
          return { objects: {"_r0": _r0}, select: _r0 }
        })
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
          _i0
          return { objects: {"_i0": _i0}, item: _i0 }
        }
        return exports
    """
    assert.is result, expected
