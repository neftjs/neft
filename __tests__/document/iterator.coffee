'use strict'

{ObservableArray} = require '@neft/core'
{createView, renderParse} = require './utils'

describe 'Document n-for', ->
    it 'loops expected times', ->
        view = createView '<ul n-for="i in ${[0,0]}">1</ul>'

        renderParse view
        assert.is view.element.stringify(), '<ul>11</ul>'

    it 'provides `item` property', ->
        view = createView '<ul n-for="item in ${[1,2]}">${item}</ul>'

        renderParse view
        assert.is view.element.stringify(), '<ul>12</ul>'

    it 'provides `index` property', ->
        view = createView '<ul n-for="(item, index) in ${[1,2]}">${index}</ul>'

        renderParse view
        assert.is view.element.stringify(), '<ul>01</ul>'

    it 'provides `array` property', ->
        view = createView '<ul n-for="(item, index, array) in ${[1,2]}">${array}</ul>'

        renderParse view
        assert.is view.element.stringify(), '<ul>1,21,2</ul>'

    it 'supports runtime updates on given observable array', ->
        view = createView '''
            <ul n-for="(item, i, each) in ${arr}">${each[i]}</ul>
            <n-props arr />
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
            <ul n-for="(item, i, each) in ${[1, 2]}">${each[i]}</ul>
            <n-props arr />
        '''

        renderParse view
        assert.is view.element.stringify(), '<ul>12</ul>'

        view.element.query('ul').props.set 'n-for', [1, 'a', 2]
        assert.is view.element.stringify(), '<ul>1a2</ul>'

    it 'access global `props`', ->
        view = createView '''
        <ul n-for="i in ${[1,2]}">${a}</ul>
        <n-props a />
        '''

        renderParse view,
            props: a: 'a'
        assert.is view.element.stringify(), '<ul>aa</ul>'

    it 'access global `props` by scope', ->
        view = createView '''
        <ul n-for="i in ${[1,2]}">${this.a}</ul>
        <n-props a />
        '''

        renderParse view,
            props: a: 'a'
        assert.is view.element.stringify(), '<ul>aa</ul>'

    it 'access `refs`', ->
        view = createView """
            <div n-ref="a" prop="a" n-if=${false} />
            <ul n-for="i in ${[1,2]}">${refs.a.props.prop}</ul>
        """

        renderParse view
        assert.is view.element.stringify(), '<ul>aa</ul>'

    it 'access component `props`', ->
        view = createView """
            <n-component name="a">
                <ul n-for="i in ${[1,2]}">${a}</ul>
                <n-props a />
            </n-component>
            <n-use n-component="a" a="a" />
        """

        renderParse view
        assert.is view.element.stringify(), '<ul>aa</ul>'

    it 'uses parent `this` scope', ->
        view = createView """
            <n-component name="a">
                <script>
                module.exports = {
                    self1: null,
                    onCreate() {
                        this.self1 = this
                    },
                    isSelf(any) {
                        return this === any
                    },
                }
                </script>
                <ul n-for="i in ${[1,2]}">${isSelf(this)}</ul>
            </n-component>
            <n-use n-component="a" />
        """

        renderParse view
        assert.is view.element.stringify(), '<ul>truetrue</ul>'

    it 'access parent component `state` object', ->
        view = createView '''
            <script>
            module.exports = {
                a: 0,
                onBeforeRender() {
                    this.a = 1
                },
            }
            </script>
            <ul n-for="i in ${[1,2]}">${a}</ul>
            <ul n-for="i in ${[1,2]}">${this.a}</ul>
        '''

        renderParse view
        assert.is view.element.stringify(), '<ul>11</ul><ul>11</ul>'

    it 'updates parent component `state` object bindings', ->
        view = createView '''
            <script>
            module.exports = {
                a: 0,
            }
            </script>
            <ul n-for="i in ${[1,2]}">${a}</ul>
            <ul n-for="i in ${[1,2]}">${this.a}</ul>
        '''

        renderParse view
        view.exported.a = 2
        assert.is view.element.stringify(), '<ul>22</ul><ul>22</ul>'

    it 'internal props are not accessible by scope', ->
        view = createView '''
            <ul n-for="i in ${[0]}">
                ${this.item}${this.index}${this.each}
            </ul>
        '''

        renderParse view
        assert.is view.element.stringify(), '<ul>undefinedundefinedundefined</ul>'

    it 'can be nested', ->
        view = createView '''
            <ul n-for="(item1, index1) in ${[1]}">
                <ul n-for="(item2, index2) in ${[2]}">
                    ${item1}|${index1}|${item2}|${index2}
                </ul>
            </ul>
        '''

        renderParse view
        assert.is view.element.stringify(), '<ul><ul>1|0|2|0</ul></ul>'

    it 'reverts components when comes invisible', ->
        view = createView '''
            <n-component name="Abc">
                <script>
                module.exports = {
                    onBeforeRevert() {
                        this.onRevertCalled();
                    },
                }
                </script>
                <n-props onRevertCalled />
            </n-component>
            <script>
            module.exports = {
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
                <ul n-for="i in ${[2]}">
                    <Abc onRevertCalled="${onChildRevert}" />
                </ul>
            </div>
        '''
        view.render()
        {exported} = view

        assert.is exported.reverted, 0
        exported.visible = false
        assert.is exported.reverted, 1
