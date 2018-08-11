'use strict'

{createView, renderParse} = require './utils.server'

describe 'Document n-if', ->
    it 'works with positive expression', ->
        source = createView '<div><b n-if="${2 > 1}">1</b></div>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<div><b>1</b></div>'

    it 'works with negative expression', ->
        source = createView '<div><b n-if="${1 > 2}">1</b></div>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<div></div>'

    it 'supports runtime updates', ->
        source = createView '''
            <n-component name="a">
                <b n-if="${props.x > 1}">OK</b>
                <b n-if="${props.x === 1}">FAIL</b>
            </n-component>
            <n-use n-component="a" x="1" />
        '''
        view = source.clone()
        elem = view.node.children[0]

        renderParse view
        assert.is view.node.stringify(), '<b>FAIL</b>'
        elem.props.set 'x', 2
        assert.is view.node.stringify(), '<b>OK</b>'
