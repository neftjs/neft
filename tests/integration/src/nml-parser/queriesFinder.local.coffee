'use strict'

nmlParser = require 'src/nml-parser'

getQueries = (nml) ->
    nmlParser.getQueries nmlParser.getAST(nml).objects

describe 'nml-parser', ->
    it 'finds queries in structure', ->
        result = getQueries '''
            Item {
                id: main
                query: 'ab > c'

                Rectangle {
                    id: child
                    query: '> d'
                }

                Item {
                    query: 'e'
                }
            }
        '''
        expected =
            'ab > c': 'main'
            'ab > c > d': 'main:child'
            'ab > c e': 'main:_i0'
        assert.isEqual result, expected

    it 'finds queries in deep types', ->
        result = getQueries '''
            Item {
                id: main

                Rectangle {
                    id: child
                    query: 'button'

                    Item {
                        Item {
                            query: 'inner'
                        }
                    }
                }
            }
        '''
        expected =
            'button': 'main:child',
            'button inner': 'main:_i0'
        assert.isEqual result, expected

    it 'finds queries in attributes', ->
        result = getQueries '''
            Item {
                id: main
                query: 'ab > c'
                content: Item {
                    query: 'd'
                }
            }
        '''
        expected =
            'ab > c': 'main'
            'ab > c d': 'main:_i0'
        assert.isEqual result, expected
