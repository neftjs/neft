'use strict'

fs = require 'fs'
pathUtils = require 'path'
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
            _RendererObject = Neft.Renderer.itemUtils.Object
            Class = Neft.Renderer.Class
            Item = Neft.Renderer.Item
            windowItem = undefined
            exports._i0 = ({document}) ->
                _i0 = Item.New()
                _RendererObject.setOpts(_i0, {"query": 'any-item'})
                _i0.onReady.emit()
                objects: {"_i0": _i0}
                item: _i0
            exports._init = (opts) ->
                windowItem = opts.windowItem
                return
            exports._main = exports._i0
            exports._mainLink = '_i0'
            exports.New = () -> exports._main({}).item
            exports._queries = {"any-item":"_i0"}
            exports._imports = {}

        '''
        assert.is result, expected

    it 'resolves imports', ->
        result = bundle nml: '''
            import Extensions.TileImage
            import Styles.ChildNamespace.CustomStyle
            TileImage {}
        '''
        expected = '''
            _RendererObject = Neft.Renderer.itemUtils.Object
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
            exports.New = () -> exports._main({}).item
            exports._queries = {}
            exports._imports = {"extensions/tileImage/renderer/tileImage":true,\
            "styles/ChildNamespace/CustomStyle":true}

        '''
        assert.is result, expected

    it 'appends constants', ->
        result = bundle nml: '''
            const abc = 1
            const func = function () {return 2}
            Item {}
        '''
        expected = '''
            _RendererObject = Neft.Renderer.itemUtils.Object
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
            exports.New = () -> exports._main({}).item
            exports._queries = {}
            exports._imports = {}

        '''
        assert.is result, expected

    it 'adds relative path', ->
        result = bundle nml: '', path: './testPath.nml'
        expected = '''
            _RendererObject = Neft.Renderer.itemUtils.Object
            Class = Neft.Renderer.Class
            windowItem = undefined
            exports._init = (opts) ->
                windowItem = opts.windowItem
                return
            exports._queries = {}
            exports._imports = {}
            exports._path = "./testPath.nml"

        '''
        assert.is result, expected

    it 'adds absolute path', ->
        path = '/home/neft/testPath.nml'
        result = bundle nml: '', path: path
        expected = pathUtils.relative fs.realpathSync('.'), path
        expected = """
            _RendererObject = Neft.Renderer.itemUtils.Object
            Class = Neft.Renderer.Class
            windowItem = undefined
            exports._init = (opts) ->
                windowItem = opts.windowItem
                return
            exports._queries = {}
            exports._imports = {}
            exports._path = "#{expected}"

        """
        assert.is result, expected
