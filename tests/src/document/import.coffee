'use strict'

{assert, unit} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

describe 'src/document import', ->
    describe 'shares components', ->
        it 'without namespace', ->
            first = "namespace#{uid()}"
            view1 = createView '<component name="a"></component>', first
            view2 = createView '<import href="' + first + '" />'

            assert.is Object.keys(view2.components).length, 1
            assert.is Object.keys(view2.components)[0], 'a'

        it 'with namespace', ->
            first = uid()
            view1 = createView '<component name="a"></component>', first
            view2 = createView '<import href="' + first + '" as="ns">'

            assert.is Object.keys(view2.components).length, 2
            assert.is Object.keys(view2.components)[0], 'ns'
            assert.is Object.keys(view2.components)[1], 'ns:a'
