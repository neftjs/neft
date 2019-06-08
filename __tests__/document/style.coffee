'use strict'

Renderer = require '@neft/core/src/renderer'
Element = require '@neft/core/src/document/element'
{createView, renderParse, createViewAndRender} = require './utils'

describe '<style />', ->
    it 'is not rendered', ->
        view = createView '''
            <style></style>
        '''

        renderParse view
        assert.is view.element.stringify(), ''

    it 'extends nodes by style items', ->
        view = createView '''
            <test />
            <style bare>
                @Item test {
                    id: firstItem
                }
            </style>
        '''

        renderParse view
        testNode = view.element.query 'test'
        assert.isEqual testNode.props['n-style'], ['__default__', 'firstItem']

    it 'can be placed in <n-component />', ->
        view = createView '''
            <n-component name="TestComp">
                <style bare>
                    @Item test {
                        id: firstItem
                    }
                </style>
                <test />
            </n-component>
            <TestComp />
        '''

        renderParse view
        testNode = view.element.query 'test'
        assert.isEqual testNode.props['n-style'], ['__default__', 'firstItem']

    it 'does not apply default style when bare is used', ->
        view = createViewAndRender '''
            <div />
            <style bare />
        '''
        assert.is view.element.query('div').style, null

    describe 'applies default style', ->
        it 'on <div />', ->
            view = createViewAndRender '<div />'
            assert.instanceOf view.element.query('div').style, Renderer.Item

        return

    it 'applies top level selects', ->
        view = createView '''
            <div class="first" />
            <style>
                .first {
                    spacing: 4
                }
            </style>
        '''

        renderParse view
        testNode = view.element.query 'div'
        assert.ok testNode.style._classList[0].running

    return

describe 'n-style', ->
    it "accepts 'style' syntax", ->
        view = createViewAndRender '''
        <b />
        <style bare>
        @Rectangle b {}
        </style>
        '''

        assert.instanceOf view.element.query('b').style, Renderer.Rectangle

    it "accepts 'style, subid' syntax", ->
        view = createViewAndRender '''
        <div><i /></div>
        <style bare>
        @Item div {
            @Rectangle i {}
        }
        </style>
        '''

        bNode = view.element.query 'div'
        iNode = view.element.query 'i'

        assert.instanceOf bNode.style, Renderer.Item
        assert.instanceOf iNode.style, Renderer.Rectangle

    it 'element is accessible in the created style document', ->
        view = createViewAndRender '''
        <b />
        <style bare>
        @Rectangle b {}
        </style>
        '''

        bNode = view.element.query 'b'
        assert.is bNode.style.element, bNode

    return

describe 'Element.Text', ->
    it 'is rendered as Renderer.Text', ->
        view = createViewAndRender '''
        <b>abc</b>
        '''

        node = view.element.query '#text'

        assert.instanceOf node, Element.Text
        assert.is node.text, 'abc'
        assert.instanceOf node.style, Renderer.Text

    it 'text is properly synchronized', ->
        view = createViewAndRender '''
        <b>abc</b>
        '''

        node = view.element.query '#text'
        item = node.style

        assert.is item.text, node.text

        node.text = '123'

        assert.is item.text, node.text

    return

describe "style: properties", ->
    it 'are set on a style item', ->
        view = createViewAndRender '''
        <b style:x={50} />
        <style bare>@Item b {}</style>
        '''

        node = view.element.query 'b'
        item = node.style

        assert.instanceOf item, Renderer.Item
        assert.is item.x, node.props['style:x']

    it 'on change are set on a style item', ->
        view = createViewAndRender '''
        <b style:x={50} />
        <style bare>@Item b {}</style>
        '''

        node = view.element.query 'b'
        item = node.style

        node.props.set 'x', 70
        assert.is item.x, node.props['style:x']

    it 'set event handlers', ->
        view = createViewAndRender '''
        <b style:onXChange="{calls += 1}" />
        <script>exports.default = { calls: 0 }</script>
        <style bare>@Item b {}</style>
        '''

        node = view.element.query 'b'
        item = node.style

        assert.is view.exported.calls, 0
        item.x = 10
        assert.is view.exported.calls, 1

        view.revert()
        view.render()

        item.x = 20
        assert.is view.exported.calls, 1

    it "is not updated when file is reverting", ->
        view = createViewAndRender '''
        <b style:x="{x}" />
        <script>exports.default = { x: 2 }</script>
        <style bare>@Item b {}</style>
        '''

        node = view.element.query 'b'
        item = node.style
        oldVals = []

        item.onXChange.connect (oldVal) -> oldVals.push oldVal

        assert.is item.x, 2
        assert.isEqual oldVals, []

        view.exported.x = 4
        assert.is item.x, 4
        assert.isEqual oldVals, [2, 0]

        view.revert()
        assert.isEqual oldVals, [2, 0]

        view.render()
        assert.is item.x, 2
        assert.isEqual oldVals, [2, 0, 4, 0]

    return

describe 'CustomTag style properties', ->
    class CustomStyle1Tag extends Element.Tag.CustomTag
        @registerAs 'custom-style-tag1'

        @defineStyleProperty
            name: 'left'
            styleName: 'x'

    it 'are set on a style item', ->
        view = createViewAndRender '''
        <custom-style-tag1 left={50} />
        <style bare>@Item custom-style-tag1 {}</style>
        '''

        node = view.element.query 'custom-style-tag1'
        item = node.style

        assert.instanceOf item, Renderer.Item
        assert.is item.x, node.props.left

    it 'on change are set on a style item', ->
        view = createViewAndRender '''
        <custom-style-tag1 left={50} />
        <style bare>@Item custom-style-tag1 {}</style>
        '''

        node = view.element.query 'custom-style-tag1'
        item = node.style

        node.props.set 'left', 70
        assert.is item.x, node.props.left

    return

describe 'item visible', ->
    it "is 'true' by default", ->
        view = createViewAndRender '''
        <b />
        <style bare>@Item b {}</style>
        '''

        assert.is view.element.query('b').style.visible, true

    it "is 'false' if the style node is invisible", ->
        view = createViewAndRender '''
        <b n-if={false} />
        <style bare>@Item b {}</style>
        '''

        assert.is view.element.query('b').style.visible, false

    it "is 'false' if the style node comes invisible", ->
        view = createViewAndRender '''
        <b />
        <style bare>@Item b {}</style>
        '''

        node = view.element.query('b')

        node.visible = false
        assert.is node.style.visible, false

    it "is 'true' if the style node comes visible", ->
        view = createViewAndRender '''
        <b n-if={false} />
        <style bare>@Item b {}</style>
        '''

        node = view.element.query('b')

        node.visible = true
        assert.is node.style.visible, true

    it "is 'false' if the not-styled node parent is invisible", ->
        view = createViewAndRender '''
        <div n-if={false}>
            <div><b /></div>
        </div>
        <style bare>@Item b {}</style>
        '''

        node = view.element.query('b')

        assert.is node.style.visible, false

    it "is 'false' if the not-styled node parent comes invisible", ->
        view = createViewAndRender '''
        <div>
            <div><b /></div>
        </div>
        <style bare>@Item b {}</style>
        '''

        node = view.element.query('div')

        node.visible = false
        assert.is view.element.query('b').style.visible, false

    it "is 'false' when not-styled node parent comes visible on invisible item", ->
        view = createViewAndRender '''
        <div n-if={false}>
            <b n-if={false} />
        </div>
        <style bare>@Item b {}</style>
        '''

        node = view.element.query('div')

        node.visible = true
        assert.is view.element.query('b').style.visible, false

    it "is 'true' if the styled node parent is invisible", ->
        view = createViewAndRender '''
        <main n-if={false}>
            <div><b /></div>
        </main>
        <style bare>@Rectangle main {} @Item b {}</style>
        '''

        bNode = view.element.query('b')

        assert.is bNode.style.visible, true

    it "is 'true' if the styled node parent comes invisible", ->
        view = createViewAndRender '''
        <main>
            <div><b /></div>
        </main>
        <style bare>@Rectangle main {} @Item b {}</style>
        '''

        divNode = view.element.query('main')
        bNode = view.element.query('b')

        divNode.visible = false
        assert.is bNode.style.visible, true

    return

describe "item parent", ->
    it "refers to the first styled parent style", ->
        view = createViewAndRender '''
        <div><b /></div>
        <style bare>@Item div, b {}</style>
        '''

        divNode = view.element.query('div')
        bNode = view.element.query('b')

        assert.is bNode.style.parent, divNode.style

    it "refers to the first styled parent style after the parent change", ->
        view = createViewAndRender '''
        <div><i /></div>
        <b />
        <style bare>@Item div, b {}</style>
        '''

        divNode = view.element.query 'div'
        iNode = view.element.query 'i'
        bNode = view.element.query 'b'

        bNode.parent = iNode
        assert.is bNode.style.parent, divNode.style

    it "is properly synchronized on 'n-use'", ->
        view = createViewAndRender '''
        <n-component name="a">
            <b />
            <i />
            <style bare>@Item b, i {}</style>
        </n-component>
        <div>
            <n-use n-component="a" />
        </div>
        <style bare>@Item div {}</style>
        '''

        divNode = view.element.query 'div'
        bNode = view.element.query 'b'
        iNode = view.element.query 'i'

        assert.is bNode.style.parent, divNode.style
        assert.is iNode.style.parent, divNode.style

    it "doesn't change if the item has a parent", ->
        view = createViewAndRender '''
        <main />
        <div><b /></div>
        <style bare>@Item div { @Item b {} } @Item main {}</style>
        '''

        mainNode = view.element.query 'main'
        divNode = view.element.query 'div'
        bNode = view.element.query 'b'

        bNode.parent = mainNode
        assert.isDefined bNode.style.parent
        assert.isNot bNode.style.parent, mainNode.style

    return

describe "Style item index", ->
    describe "is valid on", ->
        it "index change", ->
            view = createViewAndRender '''
            <div>
                <em />
                <b />
                <i />
            </div>
            <style bare>@Item div, em, b, i {}</style>
            '''

            divNode = view.element.query 'div'
            emNode = view.element.query 'em'
            bNode = view.element.query 'b'
            iNode = view.element.query 'i'

            iNode.index = 1
            assert.is iNode.style.previousSibling, emNode.style
            assert.is iNode.style.nextSibling, bNode.style

        it "parent change", ->
            view = createViewAndRender '''
            <div>
                <em />
                <b />
            </div>
            <i />
            <style bare>@Item div, b, i {}</style>
            '''

            divNode = view.element.query 'div'
            emNode = view.element.query 'em'
            bNode = view.element.query 'b'
            iNode = view.element.query 'i'

            iNode.parent = emNode
            assert.is iNode.style.nextSibling, bNode.style

        return

    it "is valid in n-for", ->
        test = ->
            childItem = divNode.style.children.firstChild
            for item in divNode.props['n-for']
                assert.is childItem.text, item + ''
                childItem = childItem.nextSibling
            return

        view = createViewAndRender '''
        <div n-for="item in {[1,2,3]}">
            <b>{item}</b>
        </div>
        <style bare>@Item div {}</style>
        '''

        divNode = view.element.query 'div'

        test()

        divNode.props.set 'n-for', [5, 6, 7, 8]
        test()
        return

    it "is preserved for item with parent", ->
        view = createViewAndRender '''
        <b>
            <em />
            <i />
        </b>
        <style bare>
        @Item em {}
        @Rectangle b {
            @Item i {}
        }
        </style>
        '''

        bNode = view.element.query 'b'
        emNode = view.element.query 'em'
        iNode = view.element.query 'i'

        assert.is emNode.style.previousSibling, iNode.style

    return
