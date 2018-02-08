'use strict'

{Document} = Neft
{createView, renderParse, uid} = require './utils.server'

describe 'Document View', ->
    it 'can be created using HTML', ->
        view = createView '<b></b>'
        assert.instanceOf view, Document

    it 'removes comments', ->
        view = createView '<!--comment--><div />'
        assert.is view.node.stringify(), '<div></div>'

    it 'finds components', ->
        view = createView '<n-component n-name="a"></n-component>'
        assert.is Object.keys(view.components).length, 1

    it 'finds uses', ->
        view = createView '''
            <n-component n-name="a"><b></b></n-component>
            <n-use n-component="a" />
        '''
        assert.is view.uses.length, 1

    it 'can be cloned and destroyed', ->
        view = createView '<b></b>'
        clone = view.clone()

        assert.isNot view, clone
        assert.isNot view.node, clone.node
        assert.is view.node.stringify(), clone.node.stringify()

    it 'is pooled on factory', ->
        path = uid()
        viewStart = createView '<b></b>', path

        viewFactored = Document.factory path
        viewFactored.destroy()
        viewRefactored = Document.factory path

        assert.isNot viewFactored, viewStart
        assert.is viewFactored, viewRefactored
