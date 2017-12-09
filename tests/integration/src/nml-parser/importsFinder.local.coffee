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
            {name: 'Class', ref: 'Neft.Renderer.Class'},
            {name: 'Item', ref: 'Neft.Renderer.Item'},
            {name: 'PropertyAnimation', ref: 'Neft.Renderer.PropertyAnimation'},
        ]
        assert.isEqual getImports(code), expected

    it 'styles', ->
        code = '''
        import Styles.Header.VerticalText
        '''
        expected = [
            {name: 'VerticalText', path: 'styles/Header/VerticalText'},
            {name: 'Class', ref: 'Neft.Renderer.Class'},
        ]
        assert.isEqual getImports(code), expected

    it 'styles', ->
        code = '''
        import Styles.Header.VerticalText
        '''
        expected = [
            {name: 'VerticalText', path: 'styles/Header/VerticalText'},
            {name: 'Class', ref: 'Neft.Renderer.Class'},
        ]
        assert.isEqual getImports(code), expected

    it 'modules', ->
        code = '''
        import Modules.VerticalText
        '''
        expected = [
            {
                name: 'VerticalText',
                path: 'node-modules/neft-vertical-text/renderer/verticalText'
            },
            {name: 'Class', ref: 'Neft.Renderer.Class'},
        ]
        assert.isEqual getImports(code), expected

    it 'Neft extensions', ->
        code = '''
        import Neft.Extensions.Video
        '''
        expected = [
            {
                name: 'Video',
                path: 'extensions/video/renderer/video'
            },
            {name: 'Class', ref: 'Neft.Renderer.Class'},
        ]
        assert.isEqual getImports(code), expected

    it 'extensions', ->
        code = '''
        import Extensions.Video
        '''
        expected = [
            {
                name: 'Video',
                path: 'extensions/video/renderer/video'
            },
            {name: 'Class', ref: 'Neft.Renderer.Class'},
        ]
        assert.isEqual getImports(code), expected
