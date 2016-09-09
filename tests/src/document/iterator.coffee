'use strict'

{assert, Dict, List, unit} = Neft
{describe, it} = unit
{createView, renderParse} = require './utils'

describe 'src/document n-each', ->
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

    it 'access global `props` by context', ->
        source = createView '<ul n-each="[1,2]">${this.props.a}</ul>'
        view = source.clone()

        renderParse view,
            props: a: 'a'
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access `refs`', ->
        source = createView """
            <div ref="a" prop="a" visible="false" />
            <ul n-each="[1,2]">${refs.a.props.prop}</ul>
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>aa</ul>'

    it 'access component `props`', ->
        source = createView """
            <component name="a" a="a">
                <ul n-each="[1,2]">${props.a}${props.b}</ul>
            </component>
            <use component="a" b="b" />
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>abab</ul>'

    it 'uses parent `this` context', ->
        source = createView """
            <component name="a">
                <script>
                    this.onCreate(function(){
                        this.self = this;
                    });
                    this.getX = function(){
                        return this === this.self ? 1 : 0;
                    };
                </script>
                <ul n-each="[1,2]">${this.getX()}</ul>
            </component>
            <use component="a" />
        """
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>11</ul>'

    it 'internal props are not accessible by context', ->
        source = createView '''
            <ul n-each="[0]">
                ${this.props.item}${this.props.index}${this.props.each}
            </ul>
        '''
        view = source.clone()

        renderParse view
        assert.is view.node.stringify(), '<ul>undefinedundefinedundefined</ul>'
