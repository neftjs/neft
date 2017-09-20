'use strict'

nmlParser = require 'src/nml-parser'

getImports = (nml) ->
    ast = nmlParser.getAST nml
    nmlParser.getImports ast

describe 'nml-parser imports', ->
    it 'default items', ->
        code = '''
        Item {
            PropertyAnimation {}
        }
        '''
        expected = [
            {name: 'Class', value: 'Neft.Renderer.Class'},
            {name: 'Item', value: 'Neft.Renderer.Item'},
            {name: 'PropertyAnimation', value: 'Neft.Renderer.PropertyAnimation'},
        ]
        assert.isEqual getImports(code), expected

    it 'styles', ->
        code = '''
        import Styles.Header.VerticalText
        '''
        expected = [
            {name: 'VerticalText', value: 'require "styles/Header/VerticalText"'},
            {name: 'Class', value: 'Neft.Renderer.Class'},
        ]
        assert.isEqual getImports(code), expected

    it 'styles', ->
        code = '''
        import Styles.Header.VerticalText
        '''
        expected = [
            {name: 'VerticalText', value: 'require "styles/Header/VerticalText"'},
            {name: 'Class', value: 'Neft.Renderer.Class'},
        ]
        assert.isEqual getImports(code), expected

    it 'modules', ->
        code = '''
        import Modules.VerticalText
        '''
        expected = [
            {
                name: 'VerticalText',
                value: 'require "node-modules/neft-vertical-text/renderer/verticalText"'
            },
            {name: 'Class', value: 'Neft.Renderer.Class'},
        ]
        assert.isEqual getImports(code), expected

    it 'Neft extensions', ->
        code = '''
        import Neft.Extensions.Video
        '''
        expected = [
            {
                name: 'Video',
                value: 'require "extensions/video/renderer/video"'
            },
            {name: 'Class', value: 'Neft.Renderer.Class'},
        ]
        assert.isEqual getImports(code), expected

    it 'extensions', ->
        code = '''
        import Extensions.Video
        '''
        expected = [
            {
                name: 'Video',
                value: 'require "extensions/video/renderer/video"'
            },
            {name: 'Class', value: 'Neft.Renderer.Class'},
        ]
        assert.isEqual getImports(code), expected
