'use strict'

{assert, unit} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

describe 'src/document use', ->
    it 'is replaced by component', ->
        view = createView '''
            <component name="a"><b></b></component>
            <use component="a" />
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), '<b></b>'

    it 'is replaced in component', ->
        source = createView '''
            <component name="b">1</component>
            <component name="a"><use component="b" /></component>
            <use component="a" />
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1'

    it 'can be rendered recursively', ->
        source = createView '''
            <component name="a">
                1
                <use
                  component="a"
                  n-if="${props.loops > 0}"
                  loops="${props.loops - 1}"
                />
            </component>
            <use component="a" loops="3" />
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '1111'

    it 'can be rendered using short syntax', ->
        view = createView '''
            <component name="a-b"><b></b></component>
            <a-b />
        '''
        view = view.clone()

        renderParse view
        assert.is view.node.stringify(), '<b></b>'
