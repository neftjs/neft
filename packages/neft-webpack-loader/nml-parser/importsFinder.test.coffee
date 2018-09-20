'use strict'

nmlParser = require './'

getImports = (nml) ->
    ast = nmlParser.getAST nml
    nmlParser.getImports ast

DEFAULT_IMPORTS = [
    {name: 'Class', ref: 'Renderer.Class'},
    {name: 'Device', ref: 'Renderer.Device'},
    {name: 'Navigator', ref: 'Renderer.Navigator'},
    {name: 'Screen', ref: 'Renderer.Screen'},
]

it 'default items', ->
    code = '''
    @Item {
        @PropertyAnimation {}
    }
    '''
    expected = [
        DEFAULT_IMPORTS...,
        {name: 'Item', ref: 'Renderer.Item'},
        {name: 'PropertyAnimation', ref: 'Renderer.PropertyAnimation'},
    ]
    assert.isEqual getImports(code), expected
