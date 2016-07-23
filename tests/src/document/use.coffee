'use strict'

{assert, unit} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

describe 'src/document use', ->
    it 'is replaced by fragment', ->
        view = createView '''
            <fragment name="a"><b></b></fragment>
            <use fragment="a" />
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), '<b></b>'

    it 'is replaced in fragment', ->
        source = createView '''
            <fragment name="b">1</fragment>
            <fragment name="a"><use fragment="b" /></fragment>
            <use fragment="a" />
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1'

    it 'can be rendered recursively', ->
        source = createView '''
            <fragment name="a">
                1
                <use
                  fragment="a"
                  n-if="${props.loops > 0}"
                  loops="${props.loops - 1}"
                />
            </fragment>
            <use fragment="a" loops="3" />
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1111'

    it 'can be rendered using short syntax', ->
        view = createView '''
            <fragment name="a-b"><b></b></fragment>
            <a-b />
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), '<b></b>'
