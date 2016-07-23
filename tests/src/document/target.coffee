'use strict'

{assert, unit} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

describe 'src/document target', ->
    it 'is replaced by the use body', ->
        source = createView '''
            <fragment name="a">
                <a1 />
                <target />
                <a2 />
            </fragment>
            <use fragment="a"><b></b></use>
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<a1></a1><b></b><a2></a2>'

    it 'can be hidden', ->
        source = createView '''
            <fragment name="a">
                <target n-if="${props.x === 1}" />
            </fragment>
            <use fragment="a" x="0"><b></b></use>
        '''
        view = source.clone()
        elem = view.node.children[0]

        renderParse view
        assert.is view.node.stringify(), ''

        elem.attrs.set 'x', 1
        assert.is view.node.stringify(), '<b></b>'
