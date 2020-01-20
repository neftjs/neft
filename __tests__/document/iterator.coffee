'use strict'

{ObservableArray} = require '@neft/core'
{createView, renderParse} = require './utils'

describe 'Document n-for', ->
    it 'loops expected times', ->
        view = createView '<ul n-for="i in {[0,0]}">1</ul>'

        renderParse view
        assert.is view.element.stringify(), '<ul>11</ul>'

    it 'provides `item` property', ->
        view = createView '<ul n-for="item in {[1,2]}">{item}</ul>'

        renderParse view
        assert.is view.element.stringify(), '<ul>12</ul>'

    it 'provides `index` property', ->
        view = createView '<ul n-for="(item, index) in {[1,2]}">{index}</ul>'

        renderParse view
        assert.is view.element.stringify(), '<ul>01</ul>'

    it 'provides `array` property', ->
        view = createView '<ul n-for="(item, index, array) in {[1,2]}">{array}</ul>'

        renderParse view
        assert.is view.element.stringify(), '<ul>1,21,2</ul>'

    it 'supports runtime updates on given observable array', ->
        view = createView '''
            <ul n-for="(item, i, each) in {arr}">{each[i]}</ul>
            <n-prop name="arr" />
        '''

        arr = new ObservableArray 1, 2

        renderParse view,
            props:
                arr: arr
        assert.is view.element.stringify(), '<ul>12</ul>'

        arr.splice 1, 0, 'a'
        assert.is view.element.stringify(), '<ul>1a2</ul>'

        arr.splice 1, 1
        assert.is view.element.stringify(), '<ul>12</ul>'

        arr.push 3
        assert.is view.element.stringify(), '<ul>123</ul>'

    it 'supports runtime updates on the n-for prop', ->
        view = createView '''
            <ul n-for="(item, i, each) in {[1, 2]}">{each[i]}</ul>
            <n-prop name="arr" />
        '''

        renderParse view
        assert.is view.element.stringify(), '<ul>12</ul>'

        view.element.query('ul').props.set 'n-for', [1, 'a', 2]
        assert.is view.element.stringify(), '<ul>1a2</ul>'

    it 'access global `props`', ->
        view = createView '''
        <ul n-for="i in {[1,2]}">{a}</ul>
        <n-prop name="a" />
        '''

        renderParse view,
            props: a: 'a'
        assert.is view.element.stringify(), '<ul>aa</ul>'

    it 'access `refs`', ->
        view = createView """
            <div n-ref="a" prop="a" n-if={false} />
            <ul n-for="i in {[1,2]}">{$refs.a.props.prop}</ul>
        """

        renderParse view
        assert.is view.element.stringify(), '<ul>aa</ul>'

    it 'access component `props`', ->
        view = createView """
            <n-component name="a">
                <ul n-for="i in {[1,2]}">{a}</ul>
                <n-prop name="a" />
            </n-component>
            <n-use n-component="a" a="a" />
        """

        renderParse view
        assert.is view.element.stringify(), '<ul>aa</ul>'

    it 'access parent component `state` object', ->
        view = createView '''
            <script>
            exports.default = {
                a: 0,
                onRender() {
                    this.a = 1
                },
            }
            </script>
            <ul n-for="i in {[1,2]}">{a}</ul>
        '''

        renderParse view
        assert.is view.element.stringify(), '<ul>11</ul>'

    it 'updates parent component `state` object bindings', ->
        view = createView '''
            <script>
            exports.default = {
                a: 0,
            }
            </script>
            <ul n-for="i in {[1,2]}">{a}</ul>
        '''

        renderParse view
        view.exported.a = 2
        assert.is view.element.stringify(), '<ul>22</ul>'

    it 'internal props are not accessible by context', ->
        view = createView '''
            <ul n-for="i in {[0]}">
                {this.item}{this.index}{this.each}
            </ul>
        '''

        renderParse view
        assert.is view.element.stringify(), '<ul></ul>'

    it 'can be nested', ->
        view = createView '''
            <ul n-for="(item1, index1) in {[1]}">
                <ul n-for="(item2, index2) in {[2]}">
                    {item1}|{index1}|{item2}|{index2}
                </ul>
            </ul>
        '''

        renderParse view
        assert.is view.element.stringify(), '<ul><ul>1|0|2|0</ul></ul>'

    it 'reverts components when comes invisible', ->
        view = createView '''
            <n-component name="Abc">
                <script>
                exports.default = {
                    onRevert() {
                        this.onRevertCalled();
                    },
                }
                </script>
                <n-prop name="onRevertCalled" />
            </n-component>
            <script>
            exports.default = {
                reverted: 0,
                visible: false,
                onChildRevert() {
                    this.reverted = this.reverted + 1;
                },
                onRender() {
                    this.visible = true
                },
            }
            </script>
            <div n-ref="container" n-if="{visible}">
                <ul n-for="i in {[2]}">
                    <Abc onRevertCalled="{onChildRevert}" />
                </ul>
            </div>
        '''
        view.render()
        {exported} = view

        assert.is exported.reverted, 0
        exported.visible = false
        assert.is exported.reverted, 1

    it 'populates `n-ref`', ->
        view = createView """
            <ul n-for="i in {[1,2]}"><div elem={i} n-ref="deepElem" /></ul>
        """

        renderParse view
        assert.ok Array.isArray(view.refs.deepElem)
        assert.isEqual Array.from(view.refs.deepElem.map((elem) => elem.props.elem)), [1, 2]

    it 'populates `n-ref` comes from `n-use`', ->
        view = createView """
            <n-component name="Abc"><n-prop name="elem" /></n-component>
            <ul n-for="i in {[1, 2]}"><Abc elem={i} n-ref="deepElem" /></ul>
        """

        renderParse view
        assert.ok Array.isArray(view.refs.deepElem)
        assert.isEqual Array.from(view.refs.deepElem.map((elem) => elem.elem)), [1, 2]

    return
