'use strict'

{assert, Dict, List, unit} = Neft
{describe, it} = unit
{createView, renderParse} = require './utils'

describe 'src/document neft:each', ->
    it 'loops expected times', ->
        source = createView '<ul neft:each="[0,0]">1</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>11</ul>'

    it 'provides `props.item` property', ->
        source = createView '<ul neft:each="[1,2]">${props.item}</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>12</ul>'

    it 'provides `props.index` property', ->
        source = createView '<ul neft:each="[1,2]">${props.index}</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>01</ul>'

    it 'provides `props.each` property', ->
        source = createView '<ul neft:each="[1,2]">${props.each}</ul>'
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>1,21,2</ul>'

    it 'supports runtime updates', ->
        source = createView '<ul neft:each="${props.arr}">${props.each[props.index]}</ul>'
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
        source = createView '<ul neft:each="[1,2]">${props.a}</ul>'
        view = source.clone()

        renderParse view,
            props: a: 'a'
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access global `props` by context', ->
        source = createView '<ul neft:each="[1,2]">${this.props.a}</ul>'
        view = source.clone()

        renderParse view,
            props: a: 'a'
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access `ids`', ->
        source = createView """
            <div id="a" prop="a" visible="false" />
            <ul neft:each="[1,2]">${ids.a.attrs.prop}</ul>
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access neft:fragment `props`', ->
        source = createView """
            <neft:fragment neft:name="a" a="a">
                <ul neft:each="[1,2]">${props.a}${props.b}</ul>
            </neft:fragment>
            <neft:use neft:fragment="a" b="b" />
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>abab</ul>'

    it 'uses parent `this` context', ->
        source = createView """
            <neft:fragment neft:name="a">
                <neft:script>
                    this.onCreate(function(){
                        this.self = this;
                    });
                    this.getX = function(){
                        return this === this.self ? 1 : 0;
                    };
                </neft:script>
                <ul neft:each="[1,2]">${this.getX()}</ul>
            </neft:fragment>
            <neft:use neft:fragment="a" />
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>11</ul>'

    it 'internal props are not accessible by context', ->
        source = createView '''
            <ul neft:each="[0]">
                ${this.props.item}${this.props.index}${this.props.each}
            </ul>
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>undefinedundefinedundefined</ul>'
