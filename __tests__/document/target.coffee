{createView, renderParse} = require './utils'

describe 'Document n-target', ->
    it 'is replaced by the use body', ->
        view = createView '''
            <n-component name="a">
                <a1 />
                <n-target />
                <a2 />
            </n-component>
            <n-use n-component="a"><b></b></n-use>
        '''

        renderParse view
        assert.is view.element.stringify(), '<a1></a1><b></b><a2></a2>'

    it 'can be hidden', ->
        view = createView '''
            <n-component name="a">
                <n-target n-if="${x === 1}" />
                <n-props x />
            </n-component>
            <n-use n-component="a" x="0"><b></b></n-use>
        '''
        elem = view.element.children[0]

        renderParse view
        assert.is view.element.stringify(), ''

        elem.props.set 'x', 1
        assert.is view.element.stringify(), '<b></b>'
