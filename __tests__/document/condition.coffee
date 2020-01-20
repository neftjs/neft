{createView, renderParse} = require './utils'

describe 'Document n-if', ->
    it 'works with positive expression', ->
        view = createView '<div><b n-if="{2 > 1}">1</b></div>'
        renderParse view
        assert.is view.element.stringify(), '<div><b>1</b></div>'

    it 'works with negative expression', ->
        view = createView '<div><b n-if="{1 > 2}">1</b></div>'
        renderParse view
        assert.is view.element.stringify(), '<div></div>'

    it 'supports runtime updates', ->
        view = createView '''
            <n-component name="Test">
                <b n-if="{x > 1}">OK</b>
                <b n-if="{x === 1}">FAIL</b>
                <n-prop name="x" />
            </n-component>
            <Test x={1} />
        '''
        elem = view.element.children[0]

        renderParse view
        assert.is view.element.stringify(), '<b>FAIL</b>'
        elem.props.set 'x', 2
        assert.is view.element.stringify(), '<b>OK</b>'

    it 'synchronizes changes with n-else', ->
        view = createView '''
            <n-component name="Test">
                <b n-if="{x > 1}">YES</b>
                <b n-else>NO</b>
                <n-prop name="x" />
            </n-component>
            <Test x={1} />
        '''
        elem = view.element.children[0]

        renderParse view
        assert.is view.element.stringify(), '<b>NO</b>'
        elem.props.set 'x', 2
        assert.is view.element.stringify(), '<b>YES</b>'

        elem.props.set 'x', 1
        assert.is view.element.stringify(), '<b>NO</b>'

    return
