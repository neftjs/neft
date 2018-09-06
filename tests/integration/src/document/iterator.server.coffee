'use strict'

{Dict, List} = Neft
{createView, renderParse} = require './utils.server'

describe 'Document n-for', ->
    it 'loops expected times', ->
        source = createView '<ul n-for="i in [0,0]">1</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>11</ul>'

    it 'provides `item` property', ->
        source = createView '<ul n-for="item in [1,2]">${item}</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>12</ul>'

    it 'provides `index` property', ->
        source = createView '<ul n-for="(item, index) in [1,2]">${index}</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>01</ul>'

    it 'provides `array` property', ->
        source = createView '<ul n-for="(item, index, array) in [1,2]">${array}</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>1,21,2</ul>'

    it 'supports runtime updates', ->
        source = createView '''
            <ul n-for="(item, i, each) in ${arr}">${each[i]}</ul>
            <n-props arr />
        '''
        view = source.clone()

        props = arr: arr = new List [1, 2]

        renderParse view, props: props
        assert.is view.node.stringify(), '<ul>12</ul>'

        arr.insert 1, 'a'
        assert.is view.node.stringify(), '<ul>1a2</ul>'

        arr.pop 1
        assert.is view.node.stringify(), '<ul>12</ul>'

        arr.append 3
        assert.is view.node.stringify(), '<ul>123</ul>'

    it 'access global `props`', ->
        source = createView '''
        <ul n-for="i in [1,2]">${a}</ul>
        <n-props a />
        '''
        view = source.clone()

        renderParse view,
            props: a: 'a'
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access global `props` by scope', ->
        source = createView '''
        <ul n-for="i in [1,2]">${this.a}</ul>
        <n-props a />
        '''
        view = source.clone()

        renderParse view,
            props: a: 'a'
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access `refs`', ->
        source = createView """
            <div n-ref="a" prop="a" visible="false" />
            <ul n-for="i in [1,2]">${refs.a.props.prop}</ul>
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access component `props`', ->
        source = createView """
            <n-component name="a">
                <ul n-for="i in [1,2]">${a}</ul>
                <n-props a />
            </n-component>
            <n-use n-component="a" a="a" />
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'uses parent `this` scope', ->
        source = createView """
            <n-component name="a">
                <script>
                exports.default = {
                    self: null,
                    onCreate() {
                        this.self = this
                    },
                    getX() {
                        return this === this.self ? 1 : 0;
                    },
                }
                </script>
                <ul n-for="i in [1,2]">${getX()}</ul>
            </n-component>
            <n-use n-component="a" />
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>11</ul>'

    it 'access parent component `state` object', ->
        source = createView '''
            <script>
            exports.default = {
                a: 0,
                onBeforeRender() {
                    this.a = 1
                },
            }
            </script>
            <ul n-for="i in [1,2]">${a}</ul>
            <ul n-for="i in [1,2]">${this.a}</ul>
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>11</ul><ul>11</ul>'

    it 'updates parent component `state` object bindings', ->
        source = createView '''
            <script>
            exports.default = {
                a: 0,
            }
            </script>
            <ul n-for="i in [1,2]">${a}</ul>
            <ul n-for="i in [1,2]">${this.a}</ul>
        '''
        view = source.clone()

        renderParse view
        view.exported.a = 2
        assert.is view.node.stringify(), '<ul>22</ul><ul>22</ul>'

    it 'internal props are not accessible by scope', ->
        source = createView '''
            <ul n-for="i in [0]">
                ${this.item}${this.index}${this.each}
            </ul>
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>undefinedundefinedundefined</ul>'

    it 'can be nested', ->
        source = createView '''
            <ul n-for="(item1, index1) in [1]">
                <ul n-for="(item2, index2) in [2]">
                    ${item1}|${index1}|${item2}|${index2}
                </ul>
            </ul>
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul><ul>1|0|2|0</ul></ul>'

    it 'reverts components when comes invisible', ->
        view = createView '''
            <n-component name="abc">
                <script>
                exports.default = {
                    onBeforeRevert() {
                        this.onRevertCalled();
                    },
                }
                </script>
                <n-props onRevertCalled />
            </n-component>
            <script>
            exports.default = {
                self: null,
                reverted: 0,
                visible: false,
                onChildRevert() {
                    this.reverted = this.reverted + 1;
                },
                onBeforeRender() {
                    this.visible = true
                },
            }
            </script>
            <div n-ref="container" n-if="${visible}">
                <ul n-for="i in [2]">
                    <abc onRevertCalled="${onChildRevert}" />
                </ul>
            </div>
        '''
        view = view.clone()
        view.render()
        {exported} = view

        assert.is exported.reverted, 0
        exported.visible = false
        assert.is exported.reverted, 1
