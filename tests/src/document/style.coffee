'use strict'

fs = require 'fs'
os = require 'os'
{assert, utils, unit, Document, styles} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

styles {queries: []}

describe 'src/document neft:style', ->
    it 'is not rendered', ->
        view = createView '''
            <neft:style></neft:style>
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), ''

    it 'extends nodes by style items', ->
        view = createView '''
            <neft:style>
                Item {
                    id: firstItem
                    document.query: 'test'
                }
            </neft:style>
            <test />
        '''
        view = view.clone()

        renderParse view
        testNode = view.node.query 'test'
        assert.isNot testNode.attrs['neft:style'].indexOf('firstItem'), -1

    it 'extends file node by main item if needed', ->
        view = createView '''
            <neft:style>
                Item {
                    id: firstItem
                }
                Item {
                    document.query: 'abc'
                }
            </neft:style>
        '''
        view = view.clone()

        renderParse view
        assert.ok view.node.attrs['neft:style']

    it 'further declarations are merged', ->
        view = createView '''
            <neft:style>
                Item {
                    id: firstItem
                    document.query: 'test'
                }
            </neft:style>
            <neft:style>
                Item {
                    id: mainItem
                }
            </neft:style>
            <test />
        '''
        view = view.clone()

        renderParse view
        testNode = view.node.query 'test'
        assert.isNot testNode.attrs['neft:style'].indexOf('firstItem'), -1
        assert.ok view.node.attrs['neft:style']

    describe '<style>', ->
        it 'is not rendered', ->
            view = createView '''
                <style></style>
            '''
            view = view.clone()

            renderParse view
            assert.is view.node.stringify(), ''

        it 'does not work if has attributes', ->
            view = createView '''
                <style src=""></style>
            '''
            view = view.clone()

            renderParse view
            assert.isNot view.node.stringify(), ''

        it 'works as neft:style', ->
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
            assert.isNot testNode.attrs['neft:style'].indexOf('firstItem'), -1
