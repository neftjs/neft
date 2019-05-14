'use strict'

{createView, renderParse} = require './utils'

describe 'Document View', ->
    it 'removes comments', ->
        view = createView '<!--comment--><div />'
        assert.is view.element.stringify(), '<div></div>'

    it 'finds components', ->
        view = createView '<n-component name="a"></n-component>'
        assert.is Object.keys(view.components).length, 1

    it 'finds uses', ->
        view = createView '''
            <n-component name="a"><b></b></n-component>
            <n-use n-component="a" />
        '''
        assert.is view.uses.length, 1
