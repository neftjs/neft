'use strict'

nmlParser = require 'src/nml-parser'

bundle = (nml) ->
    nmlParser.bundle(nml).bundle

describe 'nml-parser', ->
    it 'bundles items', ->
        result = bundle nml: '''
            Item {
                query: 'any-item'
            }
        '''
        expected = '''
            _setOpts = Neft.Renderer.itemUtils.Object.setOpts
            Class = Neft.Renderer.Class
            Item = Neft.Renderer.Item
            windowItem = undefined
            exports._i0 = ({document}) ->
                _i0 = Item.New()
                _setOpts(_i0, {"query": 'any-item'})
                _i0.onReady.emit()
                objects: {"_i0": _i0}
                item: _i0
            exports._init = (opts) ->
                windowItem = opts.windowItem
                return
            exports._main = exports._i0
            exports._mainLink = '_i0'
            exports._queries = {"any-item":"_i0"}
        '''
        assert.is result, expected

    it 'resolves imports', ->
        result = bundle nml: '''
            import Extensions.TileImage
            import Styles.ChildNamespace.CustomStyle
            TileImage {}
        '''
        expected = '''
            _setOpts = Neft.Renderer.itemUtils.Object.setOpts
            TileImage = require "extensions/tileImage/renderer/tileImage"
            CustomStyle = require "styles/ChildNamespace/CustomStyle"
            Class = Neft.Renderer.Class
            windowItem = undefined
            exports._i0 = ({document}) ->
                _i0 = TileImage.New()
                _i0.onReady.emit()
                objects: {"_i0": _i0}
                item: _i0
            exports._init = (opts) ->
                windowItem = opts.windowItem
                return
            exports._main = exports._i0
            exports._mainLink = '_i0'
            exports._queries = {}
        '''
        assert.is result, expected

    it 'appends constants', ->
        result = bundle nml: '''
            const abc = 1
            const func = function () {return 2}
            Item {}
        '''
        expected = '''
            _setOpts = Neft.Renderer.itemUtils.Object.setOpts
            Class = Neft.Renderer.Class
            Item = Neft.Renderer.Item
            abc = `1`
            func = `function () {return 2}
            `
            windowItem = undefined
            exports._i0 = ({document}) ->
                _i0 = Item.New()
                _i0.onReady.emit()
                objects: {"_i0": _i0}
                item: _i0
            exports._init = (opts) ->
                windowItem = opts.windowItem
                return
            exports._main = exports._i0
            exports._mainLink = '_i0'
            exports._queries = {}
        '''
        assert.is result, expected
