'use strict'

{createView, renderParse, uid} = require './utils.server'

describe 'Document n-target', ->
    it 'is replaced by the use body', ->
        source = createView '''
            <n-component n-name="a">
                <a1 />
                <n-target />
                <a2 />
            </n-component>
            <n-use n-component="a"><b></b></n-use>
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<a1></a1><b></b><a2></a2>'

    it 'can be hidden', ->
        source = createView '''
            <n-component n-name="a">
                <n-target n-if="${props.x === 1}" />
            </n-component>
            <n-use n-component="a" x="0"><b></b></n-use>
        '''
        view = source.clone()
        elem = view.node.children[0]

        renderParse view
        assert.is view.node.stringify(), ''

        elem.props.set 'x', 1
        assert.is view.node.stringify(), '<b></b>'
