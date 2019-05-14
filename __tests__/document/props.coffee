{createView, renderParse} = require './utils'

describe 'Document properties', ->
    # it 'are parsed to objects', ->
    #     view = createView "<a data={{a:1}}></a>"
    #     view.render()
    #     assert.isEqual view.element.children[0].props.data, a: 1

    it 'are parsed to arrays', ->
        view = createView "<a data={[1,2]}></a>"
        view.render()
        assert.isEqual view.element.children[0].props.data, [1, 2]

    it 'are parsed to numbers', ->
        view = createView "<a data={-123.1} />"
        view.render()

        attrValue = view.element.children[0].props.data
        assert.is attrValue, -123.1

    it 'math operations are not parsed', ->
        view = createView "<a data='1 + 2' />"
        view.render()

        attrValue = view.element.children[0].props.data
        assert.is attrValue, '1 + 2'

    it 'plus number is not parsed', ->
        view = createView "<a data='+2' />"
        view.render()

        attrValue = view.element.children[0].props.data
        assert.is attrValue, '+2'
