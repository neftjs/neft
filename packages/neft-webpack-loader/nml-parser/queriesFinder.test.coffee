'use strict'

nmlParser = require './'

getQueries = (nml) ->
    nmlParser.getQueries nmlParser.getAST(nml, warning: (() ->)).objects

it 'finds queries in structure', ->
    result = getQueries '''
        @Item ab > c {
            id: main

            @Rectangle > d {
                id: child
            }

            @Item e {}
        }
    '''
    expected =
        'ab > c': ['main']
        'ab > c > d': ['main', 'child']
        'ab > c e': ['main', '_i0']
    assert.isEqual result, expected

it 'finds queries in deep types', ->
    result = getQueries '''
        @Item {
            id: main

            @Rectangle button {
                id: child

                @Item {
                    @Item inner {}
                }
            }
        }
    '''
    expected =
        'button': ['main', 'child'],
        'button inner': ['main', '_i0']
    assert.isEqual result, expected

it 'finds queries in attributes', ->
    result = getQueries '''
        @Item ab > c {
            id: main
            content: @Item d {}
        }
    '''
    expected =
        'ab > c': ['main']
        'ab > c d': ['main', '_i0']
    assert.isEqual result, expected
