'use strict'

fs = require 'fs'
os = require 'os'
{assert, utils, unit, Document, styles} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

styles {queries: []}

describe 'src/document style', ->
    it 'is not rendered', ->
        view = createView '''
            <style></style>
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), ''

    it 'extends nodes by style items', ->
        view = createView '''
            <style>
                Item {
                    id: firstItem
                    document.query: 'test'
                }
            </style>
            <test />
        '''
        view = view.clone()

        renderParse view
        testNode = view.node.query 'test'
        assert.isNot testNode.props['n-style'].indexOf('firstItem'), -1

    it 'extends file node by main item if needed', ->
        view = createView '''
            <style>
                Item {
                    id: firstItem
                }
                Item {
                    document.query: 'abc'
                }
            </style>
        '''
        view = view.clone()

        renderParse view
        assert.ok view.node.props['n-style']

    it 'further declarations are merged', ->
        view = createView '''
            <style>
                Item {
                    id: firstItem
                    document.query: 'test'
                }
            </style>
            <style>
                Item {
                    id: mainItem
                }
            </style>
            <test />
        '''
        view = view.clone()

        renderParse view
        testNode = view.node.query 'test'
        assert.isNot testNode.props['n-style'].indexOf('firstItem'), -1
        assert.ok view.node.props['n-style']
