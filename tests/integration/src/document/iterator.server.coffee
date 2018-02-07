'use strict'

{Dict, List} = Neft
{createView, renderParse} = require './utils.server'

describe 'Document n-each', ->
    it 'loops expected times', ->
        source = createView '<ul n-each="[0,0]">1</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>11</ul>'

    it 'provides `props.item` property', ->
        source = createView '<ul n-each="[1,2]">${props.item}</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>12</ul>'

    it 'provides `props.index` property', ->
        source = createView '<ul n-each="[1,2]">${props.index}</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>01</ul>'

    it 'provides `props.each` property', ->
        source = createView '<ul n-each="[1,2]">${props.each}</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>1,21,2</ul>'

    it 'supports runtime updates', ->
        source = createView '<ul n-each="${props.arr}">${props.each[props.index]}</ul>'
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
        source = createView '<ul n-each="[1,2]">${props.a}</ul>'
        view = source.clone()

        renderParse view,
            props: a: 'a'
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access global `props` by scope', ->
        source = createView '<ul n-each="[1,2]">${this.props.a}</ul>'
        view = source.clone()

        renderParse view,
            props: a: 'a'
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access `refs`', ->
        source = createView """
            <div n-ref="a" prop="a" visible="false" />
            <ul n-each="[1,2]">${refs.a.props.prop}</ul>
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access component `props`', ->
        source = createView """
            <n-component n-name="a" a="a">
                <ul n-each="[1,2]">${props.a}${props.b}</ul>
            </n-component>
            <n-use n-component="a" b="b" />
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>abab</ul>'

    it 'uses parent `this` scope', ->
        source = createView """
            <n-component n-name="a">
                <script>
                    this.self = this;
                    this.getX = function(){
                        return this === this.self ? 1 : 0;
                    };
                </script>
                <ul n-each="[1,2]">${this.getX()}</ul>
            </n-component>
            <n-use n-component="a" />
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>11</ul>'

    it 'access parent component `state` object', ->
        source = createView '''
            <script>
            this.onBeforeRender(function () {
                this.state.set('a', 1);
            });
            </script>
            <ul n-each="[1,2]">${state.a}</ul>
            <ul n-each="[1,2]">${this.state.a}</ul>
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>11</ul><ul>11</ul>'

    it 'internal props are not accessible by scope', ->
        source = createView '''
            <ul n-each="[0]">
                ${this.props.item}${this.props.index}${this.props.each}
            </ul>
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>undefinedundefinedundefined</ul>'

    it 'can be nested', ->
        source = createView '''
            <ul n-each="[1]">
                <ul n-each="[2]">
                    ${props.item}|${props.index}|${props.each}
                </ul>
            </ul>
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul><ul>2|0|2</ul></ul>'

    it 'reverts components when comes invisible', ->
        view = createView '''
            <n-component n-name="abc">
                <script>
                this.onBeforeRevert(function () {
                    this.props.onRevertCalled();
                });
                </script>
            </n-component>
            <script>
            this.onChildRevert = () => {
                this.reverted = (this.reverted + 1) || 1;
            };
            this.onBeforeRender(function () {
                this.state.set('visible', true);
            });
            </script>
            <div n-ref="container" n-if="${state.visible}">
                <ul n-each="[2]">
                    <abc onRevertCalled="${this.onChildRevert}" />
                </ul>
            </div>
        '''
        view = view.clone()
        view.render()
        {scope} = view

        assert.is scope.reverted, undefined
        scope.state.set 'visible', false
        assert.is scope.reverted, 1
