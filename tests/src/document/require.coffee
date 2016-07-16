'use strict'

{assert, unit} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

describe 'src/document neft:require', ->
    describe 'shares fragments', ->
        it 'without namespace', ->
            first = "namespace#{uid()}"
            view1 = createView '<neft:fragment neft:name="a"></neft:fragment>', first
            view2 = createView '<neft:require href="' + first + '" />'

            assert.is Object.keys(view2.fragments).length, 1
            assert.is Object.keys(view2.fragments)[0], 'a'

        it 'with namespace', ->
            first = uid()
            view1 = createView '<neft:fragment neft:name="a"></neft:fragment>', first
            view2 = createView '<neft:require href="' + first + '" as="ns">'

            assert.is Object.keys(view2.fragments).length, 2
            assert.is Object.keys(view2.fragments)[0], 'ns'
            assert.is Object.keys(view2.fragments)[1], 'ns:a'
